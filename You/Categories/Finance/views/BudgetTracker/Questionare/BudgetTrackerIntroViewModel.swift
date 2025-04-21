//
//  BudgetTrackerIntroViewModel.swift
//  You
//
//  Created by Oliver Gilcher on 2/26/25.
//

import Foundation

@MainActor
final class BudgetTrackerIntroViewModel: ObservableObject {
    @Published var paychecksPerMonth = nil as Int?
    @Published var incomePerPaycheck = 0.0
    @Published var additionalIncome = 0.0
    
    @Published var housingType = ""
    @Published var housingTerm = 0
    @Published var housingAmount = 0.0
    
    @Published var debtType : [String] = []
    @Published var debtAmount = ""
}
