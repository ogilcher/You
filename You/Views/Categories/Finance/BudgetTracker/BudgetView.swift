//
//  BudgetView.swift
//  You
//
//  Created by Oliver Gilcher on 3/8/25.
//

import SwiftUI

struct BudgetView: View {
    @State var viewState : String = "planned"
    @ObservedObject var viewModel: BudgetTrackerViewModel
    
    var body: some View {
        VStack {
            // viewState switcher, date switcher & expense adder
            BudgetViewHeader(viewState: $viewState, backgroundColor: .voidBlack)
            
            // Left to budget text
            HStack (spacing: 0) {
                let remainingBudget = viewModel.currentBudget.getTotalBudgetIncome() - viewModel.currentBudget.getTotalBudgetExpenses()
                Text("$\(String(format: "%.2f", remainingBudget))")
                    .foregroundStyle(remainingBudget >= 0 ? .white : .red)
                    .font(.system(size: 18, weight: .bold))
                if remainingBudget >= 0 {
                    Text(" left to budget")
                } else {
                    Text(" over budget")
                }
            }
            .padding(.bottom, 30)
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.gray)
            
            List {
                BudgetIncomeSection(viewModel: viewModel)
                BudgetCategorySection(viewModel: viewModel, category: "giving", placeholderItems: ["Charity"])
                BudgetCategorySection(viewModel: viewModel, category: "savings", placeholderItems: ["Emergency Fund"])
                BudgetCategorySection(viewModel: viewModel, category: "housing", placeholderItems: ["Mortgage/Rent", "Water", "Natural Gas", "Electricity", "Cable", "Trash"])
                BudgetCategorySection(viewModel: viewModel, category: "transportation", placeholderItems: ["Gas", "Maintenance"])
                BudgetCategorySection(viewModel: viewModel, category: "food", placeholderItems: ["Groceries", "Restaurants"])
                BudgetCategorySection(viewModel: viewModel, category: "personal", placeholderItems: ["Clothing", "Phone", "Fun Money", "Hair/Cosmetics", "Subscriptions"])
                BudgetCategorySection(viewModel: viewModel, category: "lifestyle", placeholderItems: ["Pet Care", "Child Care", "Entertainment", "Miscellaneous"])
                BudgetCategorySection(viewModel: viewModel, category: "health", placeholderItems: ["Gym, Medicine/Vitamins", "Doctor Visits"])
                BudgetCategorySection(viewModel: viewModel, category: "insurance", placeholderItems: ["Health Insurance", "Life Insurance", "Auto Insurance", "Homeowner/Renter", "Identity Theft"])
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
        }
        
        .foregroundStyle(.white)
        .font(.system(size: 20))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct BudgetViewHeader: View {
    @State var isExpanded: Bool = false
    @Binding var viewState: String
    var backgroundColor: Color

    var optionalWidth: CGFloat = 350
    var optionalHeight: CGFloat = 30
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("pressed date button")
                } label: {
                    HStack {
                        Text(Date.now, format: .dateTime.month(.wide).year())
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    }
                    .font(.system(size: 24, weight: .bold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            .frame(width: 350)
            
            // View State Pickers
            HStack {
                // Planned button
                BudgetViewPicker(viewState: $viewState, optionalWidth: optionalWidth, optionalHeight: optionalHeight, stateText: "planned", backgroundColor: backgroundColor)
                // Spent button
                BudgetViewPicker(viewState: $viewState, optionalWidth: optionalWidth, optionalHeight: optionalHeight, stateText: "spent", backgroundColor: backgroundColor)
                // Remaining button
                BudgetViewPicker(viewState: $viewState, optionalWidth: optionalWidth, optionalHeight: optionalHeight, stateText: "remaining", backgroundColor: backgroundColor)
            }
            .font(.system(size: 16))
            .frame(width: optionalWidth, height: optionalHeight)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 5))
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .bottom)
        .background(backgroundColor)
    }
}

struct BudgetViewPicker: View {
    @Binding var viewState: String
    var optionalWidth: CGFloat
    var optionalHeight: CGFloat
    var stateText: String
    var backgroundColor: Color
    
    var body: some View {
        Button {
            viewState = stateText
        } label: {
            Text(stateText.capitalized)
        }
        .frame(width: optionalWidth/3 - 7, height: optionalHeight - 4)
        .background(viewState == stateText ? backgroundColor.opacity(0.8) : .clear)
        .clipShape(.rect(cornerRadius: 5))
    }
}

struct BudgetIncomeSection: View {
    @ObservedObject var viewModel: BudgetTrackerViewModel
    @State var isAdding : Bool = false
    
    @State var addingText: String = ""
    @State var addingAmount: Double = 0.0
    
    var body: some View {
        Section {
            HStack {
                Text("Income")
                Spacer()
                Text("Planned")
            }
            .fontWeight(.semibold)
            .foregroundStyle(.gray)
            
            ForEach(viewModel.currentBudget.expectedIncome.sorted(by: { $0.key < $1.key }), id: \.key) { source, amount in
                HStack {
                    Text(source.capitalized) // Display income source
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("$\(String(format: "%.2f", amount))") // Display amount formatted to 2 decimal places
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            if isAdding {
                HStack {
                    TextField("Item Name", text: $addingText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onSubmit {
                            viewModel.currentBudget.expectedIncome[addingText] = addingAmount
                            isAdding = false
                        }
                    HStack {
                        Text("$")
                        TextField("0.00", value: $addingAmount, format: .number)
                            .keyboardType(.decimalPad)
                            .onSubmit {
                                viewModel.currentBudget.expectedIncome[addingText] = addingAmount
                                isAdding = false
                            }
                    }
                }
            }
            Button {
                isAdding = true
            } label: {
                Text("Add Income")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.blue)
        }
    }
}

struct BudgetCategorySection: View {
    @ObservedObject var viewModel: BudgetTrackerViewModel
    @State var isAdding : Bool = false
    
    var category: String
    var placeholderItems: [String]
    
    @State var addingText: String = ""
    @State var addingAmount: Double = 0.0
    
    var body: some View {
        Section {
            HStack {
                Text(category.capitalized)
                Spacer()
                Text("Planned")
            }
            .fontWeight(.semibold)
            .foregroundStyle(.gray)
            
            ForEach(placeholderItems, id: \.self) { placeholder in
                
                BudgetCategoryPlaceholder(name: placeholder, category: category, viewModel: viewModel)
            }
            
            ForEach(viewModel.currentBudget.categoryBudgets.filter({$0.category == category}), id: \.name) { item in
                HStack {
                    Text(item.name.capitalized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("$\(String(format: "%.2f", item.amount))")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
    
            if isAdding {
                HStack {
                    TextField("Item Name", text: $addingText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onSubmit {
                            viewModel.currentBudget.categoryBudgets.append(ExpectedExpense(name: addingText, category: category, amount: 0.0, type: ExpenseType.need))
                            isAdding = false
                        }
                    HStack {
                        Text("$")
                        TextField("0.00", value: $addingAmount, format: .number)
                            .keyboardType(.decimalPad)
                            .onSubmit {
                                viewModel.currentBudget.categoryBudgets.append(ExpectedExpense(name: addingText, category: category, amount: 0.0, type: ExpenseType.need))
                                isAdding = false
                            }
                    }
                }
            }
            Button {
                isAdding = true
            } label: {
                Text("Add Item")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.blue)
        }
    }
}

struct BudgetCategoryPlaceholder: View {
    var name: String
    var category: String
    @ObservedObject var viewModel: BudgetTrackerViewModel
    
    var body: some View {
        HStack {
            Text(name)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("$0.00")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    @StateObject @Previewable var viewModel = BudgetTrackerViewModel()
    NavigationStack {
        BudgetView(viewModel: viewModel)
    }
    .onAppear {
        viewModel.load(forMonth: Date.now.formatted(.dateTime.month()))
    }
}
