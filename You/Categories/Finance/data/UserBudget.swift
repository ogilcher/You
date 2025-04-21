//
//  UserBudget.swift
//  You
//
//  Created by Oliver Gilcher on 3/4/25.
//

import Foundation

// MARK: - Budget Data Structure

struct UserBudget: Codable {
    let userID: String
    var budgets: [MonthlyBudget]
}

struct MonthlyBudget: Codable {
    let month: String // Format: "YYYY-MM"
    var income: Income
    var expenses: [Expense]
    
    // Budgeting
    var categoryBudgets: [ExpectedExpense] // Stores budget limits for categories
    var expectedIncome: [String: Double] // Stores planned income and their sources
    
    var totalSavings: Double {
        income.totalIncome - getTotalExpenses()
    }
    
    func getTotalExpenses() -> Double {
        return expenses.reduce(0) { $0 + $1.amount }
    }
    
    func getExpenses(for category: String) -> Double {
        return expenses.filter { $0.category == category }.reduce(0) { $0 + $1.amount }
    }

    func getNeedExpenses() -> Double {
        return expenses.filter { $0.type == .need }.reduce(0) { $0 + $1.amount }
    }

    func getWantExpenses() -> Double {
        return expenses.filter { $0.type == .want }.reduce(0) { $0 + $1.amount }
    }
    
    func getTotalBudgetExpenses() -> Double {
        var total = 0.0
        for cat in categoryBudgets {
            total += cat.amount
        }
        return total
//        return categoryBudgets.values.reduce(0, +)
    }
    
    func getTotalBudgetIncome() -> Double {
        return expectedIncome.values.reduce(0, +)
    }
    
//    func isOverBudget(category : String) -> Bool {
//        guard let budgetLimit = categoryBudgets[category] else { return false }
//        return getExpenses(for: category) > budgetLimit
//    }
}

struct Income: Codable {
    var paycheckSum: Double
    var additionalIncome: Double
    
    var totalIncome: Double {
        paycheckSum + additionalIncome
    }
}

struct ExpectedExpense: Codable {
    var name: String
    var category: String
    var amount: Double
    var type: ExpenseType
}

struct Expense: Codable {
    var category: String
    var amount: Double
    var date: Date
    var type: ExpenseType
}

enum ExpenseType: String, Codable {
    case need, want
}
