////
////  Expense.swift
////  You
////
////  Created by Oliver Gilcher on 2/1/25.
////
//import SwiftUI
//
//final class Expense : Identifiable {
//    var id: UUID = UUID()
//    var date: Date
//    var total: Double
//    var expenseCategory: String
//    var paymentCategory: String
//    var description: String
//    
//    init(date: Date, total: Double, expenseCategory: String, paymentCategory: String, description: String) {
//        self.date = date
//        self.total = total
//        self.expenseCategory = expenseCategory
//        self.paymentCategory = paymentCategory
//        self.description = description
//    }
//}
//
//enum ExpenseCategoryType: String, CaseIterable {
//    case housing, utilities, transportation, dining, groceries, health, entertainment
//    //, shopping
//    //, education, debt, savings, personal, subscriptions, travel, gifts, business, insurance, taxes, other
//    
//    var details: ExpenseCategory {
//        switch self {
//        case .housing: return ExpenseCategory(name: "Housing", color: .yellow, icon: "house")
//        case .utilities: return ExpenseCategory(name: "Utilities", color: .purple, icon: "lightbulb")
//        case .transportation: return ExpenseCategory(name: "Transportation", color: .blue, icon: "car")
//        case .dining: return ExpenseCategory(name: "Dining Out", color: .yellow, icon: "wineglass")
//        case .groceries: return ExpenseCategory(name: "Groceries", color: .red, icon: "fork.knife")
//        case .health: return ExpenseCategory(name: "Health", color: .pink, icon: "heart.text.clipboard")
//        case .entertainment: return ExpenseCategory(name: "Entertainment", color: .green, icon: "popcorn")
//        //case .other: return ExpenseCategory(name: "Other", color: .gray, icon: "dollarsign")
//        }
//    }
//}
//
//struct ExpenseCategory {
//    let name: String
//    let color: Color
//    let icon: String
//    
//    // Static function to get all categories if needed
//    static func getAllCategories() -> [ExpenseCategory] {
//        return ExpenseCategoryType.allCases.map { $0.details }
//    }
//}
