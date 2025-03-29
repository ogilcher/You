//
//  SwiftUIView.swift
//  You
//
//  Created by Oliver Gilcher on 1/30/25.
//

import SwiftUI
import Charts

struct BudgetTrackerView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel : BudgetTrackerViewModel
    @State var selectedDate = Date.now
    
    var body: some View {
        VStack (spacing: 40) {
            DatePicker(selectedDate: $selectedDate)
            ScrollView {
                VStack (spacing: 20) {
                    PieChartView(viewModel: viewModel)
                    ExpenseBreakDownView(viewModel: viewModel)
                }
            }
        }
        .padding()
        .foregroundStyle(.white)
        .font(.system(size: 24))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct DatePicker: View {
    @Binding var selectedDate: Date
    
    var months: [Date] {
        let calendar = Calendar.current
        let currentDate = Date()
        return (0..<6).map { offset in
            calendar.date(byAdding: .month, value: -offset, to: currentDate)!
        }.reversed()
    }
    
    var body : some View {
        HStack {
            ForEach(months, id: \.self) { month in
                VStack {
                    Text(month, format: .dateTime.year())
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Button {
                        selectedDate = month
                    } label: {
                        Text(month, format: .dateTime.month(.abbreviated))
                    }
                    .frame(width: 50, height: 30)
                    .foregroundStyle(selectedDate.description == month.description ? .black : .white)
                    .background(selectedDate.description == month.description ? .yellow : .white.opacity(0.4))
                    .clipShape(.rect(cornerRadius: 10))
                }
                .font(.system(size: 16))
            }
        }
    }
}

struct PieChartView : View {
    @ObservedObject var viewModel: BudgetTrackerViewModel
    @State private var seeDetails: Bool = false
    
    var data: [(type: String, amount: Double)] {
        let monthlyBudget = viewModel.currentBudget // Get the current month's budget
        let expenses = monthlyBudget.expenses.map { ($0.category.capitalized, $0.amount) } // Convert dictionary to array

        let sortedExpenses = expenses.sorted { $0.1 > $1.1 } // Sort by highest spending
        let topExpenses = sortedExpenses.prefix(6) // Get top 6 spendings
        let otherSum = sortedExpenses.dropFirst(6).reduce(0) { $0 + $1.1 } // Sum everything else

        var finalData = Array(topExpenses) // Store top 6 spendings

        if otherSum > 0 {
            finalData.append((type: "Other", amount: otherSum)) // Append "Other" if needed
        }

        finalData.append((type: "Savings", amount: monthlyBudget.totalSavings)) // Add savings

        return finalData
    }
    
    var body : some View {
        VStack {
            HStack {
                ZStack (alignment: .center) {
                    Chart(data, id: \.type) { dataItem in
                        SectorMark(angle: .value("Type", dataItem.amount),
                                   innerRadius: .ratio(0.85),
                                   angularInset: 1.5)
                        .cornerRadius(5)
                        .foregroundStyle(colorForType(dataItem.type))
                    }
                    .chartLegend(.hidden)
                    .frame(height: 200)
                    
                    VStack {
                        Text("Savings")
                        Text("$\(String(format: "%.2f", viewModel.currentBudget.totalSavings))")
                    }
                }
                .skeleton(Circle(), isLoading: viewModel.isLoading)
                
                VStack {
                    VStack (spacing: 10) {
                        Text("Income")
                            .foregroundStyle(.gray)
                            .font(.system(size: 16, weight: .semibold))
                        Text("+ $\(String(format: "%.2f", viewModel.currentBudget.income.totalIncome))")
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(width: 150, height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.4), lineWidth: 2))
                    VStack (spacing: 10) {
                        Text("Expenses")
                            .foregroundStyle(.gray)
                            .font(.system(size: 16, weight: .semibold))
                        Text("- $\(String(format: "%.2f", viewModel.currentBudget.getTotalExpenses()))")
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(width: 150, height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.4), lineWidth: 2))
                }
            }
            .padding()
            
            Button {
                seeDetails.toggle()
            } label: {
                Text(seeDetails ? "Hide details" : "Show details")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.gray)
            }
            
            if seeDetails {
                VStack (spacing: 10) {
                    ForEach(data.sorted(by: { $0.amount > $1.amount }), id: \.type) { dataItem in
                        HStack {
                            Text(dataItem.type)
                                .frame(width: 150, alignment: .leading)
                                .skeleton(RoundedRectangle(cornerRadius: 10), isLoading: viewModel.isLoading)
                            Spacer()
                            ProgressView(value: dataItem.amount, total: viewModel.currentBudget.income.totalIncome)
                                .progressViewStyle(
                                    ColoredCustomProgressViewStyle(height: 10, width: 150, baseColor: .gray.opacity(0.4), frontColor: colorForType(dataItem.type))
                                )
                                .skeleton(Capsule(), isLoading: viewModel.isLoading)
                            Text("$\(Int(dataItem.amount))")
                                .frame(width: 55, alignment: .trailing)
                                .skeleton(RoundedRectangle(cornerRadius: 10), isLoading: viewModel.isLoading)
                        }
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 16))
                    }
                }
            }
        }
    }
    
    func colorForType(_ type: String) -> Color {
        switch (type) {
        case "Housing": return .green
        case "Groceries": return .blue
        case "Gas": return .orange
        case "Utilities": return .teal
        case "Phone": return .yellow
        case "Dining": return .purple
        case "Fees": return .brown
        case "Savings": return .white
        case "Entertainment": return .red
        case "Transportation": return .indigo
        case "Other": return .mint
        default: return .black
        }
    }
}

struct ExpenseBreakDownView: View {
    @ObservedObject var viewModel: BudgetTrackerViewModel
    
    var body: some View {
        HStack {
            ExpenseTypeChartView(viewModel: viewModel, expenseType: ExpenseType.need)
            VStack {
                Text("Needs")
                    .foregroundStyle(.gray)
                    .font(.system(size: 16, weight: .semibold))
                Text("$\(String(format: "%.2f", viewModel.currentBudget.getNeedExpenses()))")
                    .font(.system(size: 20, weight: .bold))
            }
            .frame(width: 150, height: 100)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.4), lineWidth: 2))
        }
        HStack {
            ExpenseTypeChartView(viewModel: viewModel, expenseType: ExpenseType.want)
            VStack (spacing: 10) {
                Text("Wants")
                    .foregroundStyle(.gray)
                    .font(.system(size: 16, weight: .semibold))
                Text("$\(String(format: "%.2f", viewModel.currentBudget.getWantExpenses()))")
                    .font(.system(size: 20, weight: .bold))
            }
            .frame(width: 150, height: 100)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.4), lineWidth: 2))
        }
    }
}

struct ExpenseTypeChartView: View {
    @ObservedObject var viewModel: BudgetTrackerViewModel
    var expenseType: ExpenseType
    
    var spendingData: [(day: Int, totalSpent: Double)] {
        let calendar = Calendar.current
        let currentMonth = viewModel.currentBudget
        
        var dailySpending: [Int: Double] = [:]
        
        // Sum expenses per day
        for expense in currentMonth.expenses {
            // Filter out values of type 'need'
            if (expense.type == expenseType) {
                let day = calendar.component(.day, from: expense.date)
                dailySpending[day, default: 0] += expense.amount
            }
        }
        
        // Ensure we have all 30 days, filling missing days with 0
        return (1...30).map { day in
            (day: day, totalSpent: dailySpending[day] ?? 0)
        }
    }
    
    var body: some View {
        Chart {
            ForEach(spendingData, id: \.day) { entry in
                LineMark(
                    x: .value("Day", entry.day),
                    y: .value("Total Spent", entry.totalSpent)
                )
                .foregroundStyle(.yellow)
                .interpolationMethod(.catmullRom)
            }
        }
        .frame(width: 200, height: 150)
        .padding()
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxis {
            AxisMarks(values: Array(stride(from: 1, to: 31, by: 5))) // Show labels every 5 days
        }
    }
    
}

#Preview {
    @StateObject @Previewable var viewModel = BudgetTrackerViewModel()
    
    NavigationStack {
        BudgetTrackerView(viewModel: viewModel)
    }.onAppear {
        viewModel.load(forMonth: Date.now.formatted(.dateTime.month()))
    }
}
