//
//  SwiftUIView.swift
//  You
//
//  Created by Oliver Gilcher on 1/30/25.
//

import SwiftUI
import Charts

struct BudgetTrackerView: View {
    @AppStorage("backgroundColor") private var backgroundColor: String?
    
    private var expenses = [Expense(date: Date(), total: 100, expenseCategory: ".dining", paymentCategory: "cash", description: "nothing to see here")]
    
    var body: some View {
        NavigationStack {
            VStack {
//                Chart {
//                    ForEach(expenses, id: \.id) { expense in
//                        BarMark(
//                            x: .value("Date", expense.date, unit: .month),
//                            y: .value("Total", expense.total)
//                        )
//                        .anotation(position: .top, alignment: .center) {
//                            Text("\(expenses.)")
//                        }
//                    }
//                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.fromString(from: backgroundColor).gradient)
        }
    }
}

#Preview {
    BudgetTrackerView()
}
