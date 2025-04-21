//
//  BudgetHousingQuestions.swift
//  You
//
//  Created by Oliver Gilcher on 2/28/25.
//

import SwiftUI

struct BudgetHousingQuestions: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Housing")
                .font(.system(size: 30, weight: .bold))
            Text("What is your housing situation?")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button { // Renting
                viewModel.housingType = "renting"
            } label: {
                HStack {
                    Image(systemName: "circle")
                    Text("Renting")
                }
            }
            .padding()
            .frame(width: 350, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.housingType.elementsEqual("renting") ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Button { // Mortgage
                viewModel.housingType = "mortgage"
            } label: {
                HStack {
                    Image(systemName: "circle")
                    Text("Mortgage")
                }
            }
            .padding()
            .frame(width: 350, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.housingType.elementsEqual("mortgage") ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Button { // Rent Free
                viewModel.housingType = "rentfree"
            } label: {
                HStack {
                    Image(systemName: "circle")
                    Text("Rent Free")
                }
            }
            .padding()
            .frame(width: 350, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.housingType.elementsEqual("rentfree") ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Spacer()
            
            if viewModel.housingType.elementsEqual("rentfree") {
                NavigationLink(
                    destination: BudgetDebtQuestions(viewModel: viewModel).navigationBarBackButtonHidden(true),
                    label: {
                        Text("Continue")
                            .frame(width: 350, height: 55)
                            .background(.blue)
                            .clipShape(.capsule)
                    }
                )
            } else { // Ask about their housing term and cost
                NavigationLink(
                    destination: BudgetHousingAmountQuestion(viewModel: viewModel).navigationBarBackButtonHidden(true),
                    label: {
                        Text("Continue")
                            .frame(width: 350, height: 55)
                            .background(.blue)
                            .clipShape(.capsule)
                    }
                )
            }
            
        }
        .padding()
        .font(.system(size: 24))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct BudgetHousingAmountQuestion : View {
    @ObservedObject var viewModel : BudgetTrackerIntroViewModel
    
    @State var givenTerm : Double = 0.0
    @State var isMonths : Bool = true
    
    var body : some View {
        VStack (spacing: 30) {
            Text("Housing")
                .font(.system(size: 30, weight: .bold))
            Text("How much a month do you pay?")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("$")
                TextField("0.00", value: $viewModel.housingAmount, format: .number)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                Text("/ month")
            }
            .padding()
            .frame(width: 350, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.housingType.elementsEqual("rentfree") ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Text(viewModel.housingType.elementsEqual("renting") ? "How long is your lease?" : "How long is your mortgage?")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                TextField("0", value: $givenTerm, format: .number)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                HStack {
                    Button {
                        isMonths = true
                    } label: {
                        Text("Months")
                    }
                    .frame(width: 100, height: 55)
                    .background(isMonths ? .white.opacity(0.4) : .clear)
                    .clipShape(.rect(cornerRadius: 10))
                    
                    Button {
                        isMonths = false
                    } label: {
                        Text("Years")
                    }
                    .frame(width: 100, height: 55)
                    .background(isMonths ? .clear : .white.opacity(0.4))
                    .clipShape(.rect(cornerRadius: 10))
                }
                .frame(width: 200, height: 55)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.opacity(0.4), lineWidth: 2))
            }
            .padding()
            .frame(width: 350, height: 55, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.housingType.elementsEqual("rentfree") ? .white : .white.opacity(0.4), lineWidth: 2)
            )
            
            Spacer()
            
            NavigationLink(
                destination: BudgetDebtQuestions(viewModel: viewModel).navigationBarBackButtonHidden(true),
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

#Preview {
    @Previewable @StateObject var viewModel = BudgetTrackerIntroViewModel()
    BudgetHousingAmountQuestion(viewModel: viewModel)
}
