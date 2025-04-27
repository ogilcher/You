//
//  BudgetTrackerViewModel.swift
//  You
//
//  Created by Oliver Gilcher on 3/4/25.
//

import Foundation

@MainActor
final class BudgetTrackerViewModel : ObservableObject {
    @Published var isLoading: Bool = true
    @Published var currentBudget: MonthlyBudget = MonthlyBudget(
        month: Date.now.formatted(.dateTime.month()),
        income: Income(paycheckSum: 0.0, additionalIncome: 0.0),
        expenses: [],
        categoryBudgets: [],
        expectedIncome: [:]
    )
    
    func load (forMonth month: String) {
        let sampleBudget = UserBudget(
            userID: "12345",
            budgets: [
                MonthlyBudget(
                    month: Date.now.formatted(.dateTime.month()),
                    income: Income(paycheckSum: 4320.96, additionalIncome: 423.56),
                    expenses: [
                        Expense(category: "housing", amount: 2650.83, date: Date.now, type: .need),
                        Expense(category: "utilities", amount: 516.72, date: Date.now, type: .need),
                        Expense(category: "groceries", amount: 723.95, date: Date.now, type: .need),
                        Expense(category: "gym_membership", amount: 15, date: Date.now, type: .want),
                        Expense(category: "dining", amount: 130.46, date: Date.now, type: .want),
                        Expense(category: "entertainment", amount: 372.12, date: Date.now, type: .want),
                        Expense(category: "phone", amount: 60.32, date: Date.now, type: .need),
                        Expense(category: "transportation", amount: 450.23, date: Date.now, type: .need)
                    ],
                    categoryBudgets: [
                        ExpectedExpense(name: "rent", category: "housing", amount: 2700.00, type: ExpenseType.need),
                        ExpectedExpense(name: "water", category: "housing", amount: 130.27, type: ExpenseType.need),
                        ExpectedExpense(name: "groceries", category: "food", amount: 800.00, type: ExpenseType.need),
                        ExpectedExpense(name: "entertainment", category: "lifestyle", amount: 400.00, type: ExpenseType.want),
                        ExpectedExpense(name: "phone", category: "personal", amount: 65.00, type: ExpenseType.need)
                        
//                        "housing": 2700.00,
//                        "utilities": 550.00,
//                        "groceries": 800.00,
//                        "gym_membership": 25.00,
//                        "dining": 200.00,
//                        "entertainment": 400.00,
//                        "phone": 65.00,
//                        "transportation": 500.00
                    ],
                    expectedIncome: [
                        "Paycheck 1" : 2000.00,
                        "Paycheck 2" : 2362.00,
                        "Side Hustle": 320.00
                    ]
                )
            ]
        )
        
        var budgets: [MonthlyBudget] = []
        budgets.append(sampleBudget.budgets.first!)
        
        if let budget = budgets.first(where: { $0.month == month }) {
            self.currentBudget = budget
        } else {
            self.currentBudget = MonthlyBudget(
                month: Date.now.formatted(.dateTime.month()),
                income: Income(paycheckSum: 0.0, additionalIncome: 0.0),
                expenses: [],
                categoryBudgets: [],
                expectedIncome: [:]
            )
        }
        isLoading = false
    }
    
    func addBudgetIncome(type: String, amount: Double) {
        print("Added budget income to object")
    }
    
    func removeBudgetIncome(type: String, amount: Double) {
        print("Removed budget income from object")
    }
    
    func editBudgetIncome(from: String, to: String, amount: Double) {
        print("Edited budget income from object")
    }
    
    
}
