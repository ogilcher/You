//
//  FinanceProfile.swift
//  You
//
//  Created by Oliver Gilcher on 3/5/25.
//

import Foundation

struct FinanceProfile : Codable {
    let userID: String
    
    // Income
    var paychecksPerMonth: Int
    var incomePerPaycheck: Double
    var additionalIncome: Double
    
    // Housing
    var housingType: String
    var housingTerm: Int
    var housingCost: Double
    
    // Fixed expenses
    var utilities: Double?
    var insurance: Double?
    var transportation: Double?
    var childcare: Double?
    var subscriptions: Double?
    
    // Variable expenses
    var groceries: Double?
    var dining: Double?
    var entertainment: Double?
    var shopping: Double?
    
    // Savings & Investments
    var emergencyFund: Double
    var retirementSavings: Double
    var bigPurchases: Double
    var otherSavings: Double
    
    var financialGoals: [String] // Paying off debt, traveling, starting a business, etc..
    
    var budgetingPreference: String // 50/30/20, 70/20/10, Zero-based, Envelope
}
