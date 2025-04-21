//
//  BudgetDebtQuestions.swift
//  You
//
//  Created by Oliver Gilcher on 2/28/25.
//

import SwiftUI

struct BudgetDebtQuestions: View {
    @ObservedObject var viewModel : BudgetTrackerIntroViewModel
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Debt")
            Text("What types of debt do you have? (select all that apply)")
            
            ScrollView {
                // Home Equity Loan/HELOC
                // IRS
                // Medical
                // Mortgage
                // Personal
                // Student Loan
                // 401(k) Loan
                // Other
            }
            
            NavigationLink(
                destination: self.navigationBarBackButtonHidden(true),
                label: {
                    Text("Skip")
                        .frame(width: 350, height: 55)
                        .background(.blue)
                        .clipShape(.capsule)
                }
            )
            
            Button {
                print("paychecks per month: \(String(describing: viewModel.paychecksPerMonth))\n income per paycheck: \(viewModel.incomePerPaycheck)\n additional income: \(viewModel.additionalIncome)\n housing type: \(viewModel.housingType)\n housing term: \(viewModel.housingTerm)\n housing cost: \(viewModel.housingAmount)")
            } label: {
                Text("Print")
            }
        }
        .padding()
        .foregroundStyle(.white)
        .font(.system(size: 24))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct DebtButton : View {
    @ObservedObject var viewModel : BudgetTrackerIntroViewModel
    var name : String
    
    var body : some View {
        HStack {
            Image(systemName: "circle")
            Text(name)
        }
    }
}

#Preview {
    @Previewable @ObservedObject var viewModel = BudgetTrackerIntroViewModel()
    
    BudgetDebtQuestions(viewModel: viewModel)
}
