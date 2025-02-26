//
//  BudgetTrackerIntro.swift
//  You
//
//  Created by Oliver Gilcher on 2/25/25.
//

import SwiftUI

@MainActor
final class BudgetTrackerIntroViewModel: ObservableObject {
    @Published var paychecksPerMonth = nil as Int?
    @Published var incomePerPaycheck = ""
    
    @Published var housingType = ""
    @Published var housingTerm = ""
    @Published var housingAmount = ""
    
    @Published var debtType = ""
    @Published var debtAmount = ""
}

struct BudgetTrackerIntro1: View {
    @AppStorage("backgroundColor") private var backgroundColor: String?
    @Environment(\.dismiss) private var dismiss   // Dismiss view
    @StateObject private var viewModel = BudgetTrackerIntroViewModel()
    
    var body: some View {
        VStack (spacing: 30) {
            Text("How often do you get paid?")
                .padding(.horizontal, 15)
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Button { // Weekly
                viewModel.paychecksPerMonth = 4
            } label: {
                HStack {
                    Image(systemName: (viewModel.paychecksPerMonth == 4) ? "checkmark.circle" : "circle")
                    Text("Weekly")
                }
                .padding()
                .frame(width: 350, height: 55, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
            Button { // BiWeekly
                viewModel.paychecksPerMonth = 2
            } label: {
                HStack {
                    Image(systemName: (viewModel.paychecksPerMonth == 2) ? "checkmark.circle" : "circle")
                    Text("Twice a month")
                }
                .padding()
                .frame(width: 350, height: 55, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
            Button { // Monthly
                viewModel.paychecksPerMonth = 1
            } label: {
                HStack {
                    Image(systemName: (viewModel.paychecksPerMonth == 1) ? "checkmark.circle" : "circle")
                    Text("Monthly")
                }
                .padding()
                .frame(width: 350, height: 55, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
            Button { // Irregularly / Not working
                viewModel.paychecksPerMonth = 0
            } label: {
                HStack {
                    Image(systemName: (viewModel.paychecksPerMonth == 0) ? "checkmark.circle" : "circle")
                    Text("Irregularly / Unemployed")
                }
                .padding()
                .frame(width: 350, height: 55, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
            
            Spacer()
            
            NavigationLink( // Continue button
                destination: BudgetTrackerIntro2(viewModel: viewModel).navigationBarBackButtonHidden(true),
                label: {
                    Text("Continue")
                        .frame(width: 350, height: 55)
                        .background(.blue)
                        .clipShape(.capsule)
                }
            )
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 1, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.fromString(from: backgroundColor).gradient)
    }
}

struct BudgetTrackerIntro2: View {
    @AppStorage("backgroundColor") private var backgroundColor: String?
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    
    @Environment(\.dismiss) private var dismiss   // Dismiss view
    
    var body : some View {
        VStack (spacing: 30) {
            Text("Roughly, how much do you make per paycheck?")
                .padding(.horizontal, 15)
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack { // Entry Field for income per paycheck
                Text("$")
                TextField("0.00", text: $viewModel.incomePerPaycheck)
                    .submitLabel(.done)
            }
            .padding()
            .frame(width: 350, height: 55)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.clear)
                    .stroke(Color.white.opacity(0.4), lineWidth: 2)
            )
            
            Spacer()
            
            NavigationLink( // Continue button
                destination: BudgetTrackerIntro3(viewModel: viewModel).navigationBarBackButtonHidden(true),
                label: {
                    Text("Continue")
                        .frame(width: 350, height: 55)
                        .background(.blue)
                        .clipShape(.capsule)
                }
            )
        }
        .onAppear {
            if viewModel.paychecksPerMonth == nil {
                viewModel.paychecksPerMonth = 0
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 2, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.fromString(from: backgroundColor).gradient)
    }
    
}

struct BudgetTrackerIntro3: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    @Environment(\.dismiss) private var dismiss   // Dismiss view
    
    var body : some View {
        VStack (spacing: 30) {
            Text("What is your housing situation?")
                .padding(.horizontal, 15)
                .font(.system(size: 30, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button { // Mortgage
                viewModel.housingType = "mortgage"
            } label: {
                HStack {
                    Image(systemName: (viewModel.housingType.elementsEqual("mortgage")) ? "checkmark.circle" : "circle")
                    Text("Mortgage")
                }
                .padding()
                .frame(width: 350, height: 55, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
            
            Button { // Renting
                viewModel.housingType = "renting"
            } label: {
                HStack {
                    Image(systemName: (viewModel.housingType.elementsEqual("renting")) ? "checkmark.circle" : "circle")
                    Text("Renting")
                }
                .padding()
                .frame(width: 350, height: 55, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
            
            Button { // Rent Free
                viewModel.housingType = "rentfree"
            } label: {
                HStack {
                    Image(systemName: (viewModel.housingType.elementsEqual("rentfree")) ? "checkmark.circle" : "circle")
                    Text("Rent-Free")
                }
                .padding()
                .frame(width: 350, height: 55, alignment: .leading)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white.quinary, lineWidth: 2))
            }
            
            // Get the user's housing term and monthly cost
            if !viewModel.housingType.elementsEqual("rentfree") && !viewModel.housingType.isEmpty {
                Text("How long is your \(viewModel.housingType.elementsEqual("mortgage") ? "mortgage" : "lease")?")
                HStack {
                    TextField("0", text: $viewModel.housingTerm)
                        .keyboardType(.numberPad)
                    Text("Months")
                }
                .padding()
                .frame(width: 350, height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                )
                Text("How much do you pay a month?")
                HStack {
                    Text("$")
                    TextField("0.00", text: $viewModel.housingAmount)
                        .keyboardType(.decimalPad)
                }
                .padding()
                .frame(width: 350, height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                )
            }
            
            NavigationLink( // Continue button
                destination: BudgetTrackerIntro4(viewModel: viewModel).navigationBarBackButtonHidden(true),
                label: {
                    Text("Continue")
                        .frame(width: 350, height: 55)
                        .background(.blue)
                        .clipShape(.capsule)
                }
            )
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 3, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient) // TODO: Fix background color
    }
}

struct BudgetTrackerIntro4: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body : some View {
        VStack {
            Text("Depts")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 4, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct BudgetTrackerIntro5: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body : some View {
        VStack {
            Text("Depts")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 5, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct BudgetTrackerIntro6: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body : some View {
        VStack {
            Text("Depts")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 6, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct BudgetTrackerIntro7: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body : some View {
        VStack {
            Text("Fixed Expenses")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 6, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct BudgetTrackerIntro8: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body : some View {
        VStack {
            Text("Variable Expenses")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 6, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}

struct BudgetTrackerIntro9: View {
    @ObservedObject var viewModel: BudgetTrackerIntroViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body : some View {
        VStack {
            Text("Savings and Expenses")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                ProgressView(value: 6, total: 8)
                    .progressViewStyle(CustomProgressViewStyle(height: 15))
                    .frame(width: 300)
            }
        }
        .font(.system(size: 24))
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
    }
}




#Preview {
    @Previewable @StateObject var viewModel = BudgetTrackerIntroViewModel()
    
    NavigationStack {
        BudgetTrackerIntro1()
    }
}
