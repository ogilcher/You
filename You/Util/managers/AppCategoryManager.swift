//
//  AppCategoryManager.swift
//  You
//
//  Created by Oliver Gilcher on 2/4/25.
//

import SwiftUI
import SwiftData

@Model
final class AppCategory : Identifiable {
    var itemID: Int = 0
    var angle: Double = 0.0
    
    var title: String
    var image: String
    var color: String
    var destination: String
    
    init(title: String, image: String, color: String, destination: String) {
        self.title = title
        self.image = image
        self.color = color
        self.destination = destination
    }
}

final class SubApp : Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String?
    var color: Color
    var image1: String
    var image2: String?
    var destination: AnyView
    var parentCategory: AppCategory
    
    init(title: String, description: String?, color: Color, image1: String, image2: String?, destination: AnyView, parentCategory: AppCategory) {
        self.title = title
        self.description = description
        self.color = color
        self.image1 = image1
        self.image2 = image2
        self.destination = destination
        self.parentCategory = parentCategory
    }
}

final class AppCategoryManager {
    static let shared = AppCategoryManager()
    private init() {}
    
    func getAppCategories() -> [AppCategory] {
        return AppCategoryType.allCases.map(\.details)
    }
    
    func getSubApp(for app : String) -> SubApp {
        return SubAppType.allCases.first(where: { $0.rawValue == app })!.details
    }
    
    func getSubApps(for category: String) -> [String] {
        return SubAppType.allCases
            .filter { $0.details.parentCategory.title.lowercased() == category.lowercased() }
            .map { $0.rawValue }
    }
    
    enum AppCategoryType: String, CaseIterable {
        case finance/*, education, productivity, homeManagement, career, travel, shopping, relationships, mentalHealth, creativeHobbies, petCare, automotive, techManagement, social, selfImprovement, emergencyPrep, parenting, dining, sustainability, gaming*/
        
        var details: AppCategory {
            switch self {
            case .finance: return AppCategory(title: "Finance", image: "dollarsign", color: "lushForest", destination: "Finance_Landing")
            //case .education: return AppCategory(title: "Education", image: "graduationcap.fill", color: Color.blue, destination: AnyView())
//            default: return AppCategory(title: "Homescreen", image: "house.fill", color: "slateGray", destination: "HomeScreen")
            }
        }
    }
    
    enum SubAppType: String, CaseIterable {
        case mortgageCalculator, tipCalculator
        
        var details: SubApp {
            switch self {
            case .mortgageCalculator: return SubApp(title: "Mortgage Calculator", description: "Calculates mortgage payments and interest.", color: Color.teal, image1: "square.and.pencil", image2: "chart.line.uptrend.xyaxis", destination: AnyView(MortgageCalculator()), parentCategory: AppCategoryType.finance.details)
            case .tipCalculator: return SubApp(title: "Tip Calculator", description: "Calculates tip and total bill.", color: Color.orange, image1: "dollarsign.square", image2: nil, destination: AnyView(TipCalculator()), parentCategory: AppCategoryType.finance.details)
            }
        }
    }
}
