//
//  BudgetIncomeQuestions.swift
//  You
//
//  Created by Oliver Gilcher on 2/26/25.
//

import SwiftUI

struct BudgetIncomeQuestions: View {
    @StateObject private var viewModel = BudgetTrackerIntroViewModel()
    @State var hasFinished: Bool = false
    
    var body: some View {
        VStack {
            Text("Income")
                .font(.system(size: 30, weight: .bold))
            
            TabView {
                IncomeQuestion(paychecksPerMonth: $viewModel.paychecksPerMonth, incomePerPaycheck: $viewModel.incomePerPaycheck)
                AdditionalIncomeQuestion(additionalIncome: $viewModel.additionalIncome)
            }
            .padding()
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(width: 350, height: 600)
//            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.quinary, lineWidth: 2))
            
            Spacer()
            
            NavigationLink( // Continue button
                destination: BudgetHousingQuestions(viewModel: viewModel).navigationBarBackButtonHidden(true),
                label: {
                    Text("Continue")
                        .frame(width: 350, height: 55)
                        .background(.blue)
                        .clipShape(.capsule)
                }
            )
        }
        .padding()
        .foregroundStyle(.white)
        .font(.system(size: 24))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct IncomeQuestion : View {
    @Binding var paychecksPerMonth : Int?
    @Binding var incomePerPaycheck : Double
    
    var body : some View {
        VStack (spacing: 20) {
            Text("How often do you get paid?")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button { // Weekly
                paychecksPerMonth = 4
            } label: {
                HStack {
                    Image(systemName: paychecksPerMonth == 4 ? "checkmark.circle" : "circle")
                    Text("Weekly")
                }
            }
            .padding()
            .frame(width: 300, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(paychecksPerMonth == 4 ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Button { // Bi-weekly
                paychecksPerMonth = 2
            } label: {
                HStack {
                    Image(systemName: paychecksPerMonth == 2 ? "checkmark.circle" : "circle")
                    Text("Every two weeks")
                }
            }
            .padding()
            .frame(width: 300, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(paychecksPerMonth == 2 ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Button { // Monthly
                paychecksPerMonth = 1
            } label: {
                HStack {
                    Image(systemName: paychecksPerMonth == 1 ? "checkmark.circle" : "circle")
                    Text("Monthly")
                }
            }
            .padding()
            .frame(width: 300, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(paychecksPerMonth == 1 ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Button { // Unemployed
                paychecksPerMonth = 0
            } label: {
                HStack {
                    Image(systemName: paychecksPerMonth == 0 ? "checkmark.circle" : "circle")
                    Text("Irregularly / None")
                }
            }
            .padding()
            .frame(width: 300, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(paychecksPerMonth == 0 ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            if paychecksPerMonth != 0 && paychecksPerMonth != nil {
                Text("Paycheck amount?")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack { // Income per paycheck
                    Text("$")
                    TextField("0.00", value: $incomePerPaycheck, format: .number)
                        .keyboardType(.decimalPad)
                        .submitLabel(.done)
                }
                .padding()
                .frame(width: 300, height: 55)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
        }
    }
}

struct AdditionalIncomeQuestion : View {
    @Binding var additionalIncome : Double
    
    var body : some View {
        VStack (spacing: 20) {
            Text("Do you have any other sources of income?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            HStack {
                Text("$")
                TextField("0.00", value: $additionalIncome, format: .number)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                Text("/ month")
            }
            .padding()
            .frame(width: 300, height: 55)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
        }
    }
}

#Preview {
    NavigationStack {
        BudgetIncomeQuestions()
    }
}
