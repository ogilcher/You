//
//  MortageCalculator.swift
//  You
//
//  Created by Oliver Gilcher on 1/28/25.
//

// TODO: Done enough, pretty the rest of the view up and add tactiles and animations

import SwiftUI

struct MortgageCalculator : View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("backgroundColor") var backgroundColor: String?
    
    @State var loanAmount : String = ""
    @State var monthlyPayments : Double = 0
    @State var totalInterestPaid : Double = 0
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 40) {
                //MortgageCalculatorHeader()
                
                MortgageTotalView(monthlyPayments: $monthlyPayments, totalInterestPaid: $totalInterestPaid, loanAmount: $loanAmount)
                
                MortgageEntriesView(loanAmount: $loanAmount, monthlyPayments: $monthlyPayments, totalInterestPaid: $totalInterestPaid)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .padding()
            .background(Color.fromString(from: backgroundColor).gradient)
        }
        .navigationTitle("Mortgage Calculator")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(
                    action: {dismiss()},
                    label: {Image(systemName: "chevron.left")}
                )
                .foregroundStyle(.white)
            }
        }
    }
}

struct MortgageCalculatorHeader : View {
    var body : some View {
        HStack {
            NavigationLink(
                destination: Finance_Landing().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "chevron.left")
                }
            )
            Spacer()
            Text("Mortgage Calculator")
            Spacer()
        }
        .font(.system(size: 25, weight: .bold))
        .foregroundStyle(.white)
    }
}

struct MortgageTotalView : View {
    @Binding var monthlyPayments : Double
    @Binding var totalInterestPaid : Double
    @Binding var loanAmount : String
    
    var body : some View {
        VStack (spacing: 20) {
            Text("Monthly payments")
                .font(.system(size: 20, weight: .semibold))
            Text("$\(monthlyPayments == 0 ? "0.00" : String(format: "%.2f", monthlyPayments))")
                .font(.system(size: 20, weight: .bold))
            
            VStack {
                HStack {
                    Text("Total principal paid")
                    Spacer()
                    Text("$\(Double(loanAmount) ?? 0, specifier: "%.2f")")
                }
                
                Divider()
                
                HStack {
                    Text("Total interest paid")
                    Spacer()
                    Text("$\(totalInterestPaid == 0 ? "0.00" : String(format: "%.2f", totalInterestPaid))")
                }
            }
            .padding(.horizontal)
            .frame(width: 340, height: 75)
            .background(.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 15))
        }
        .padding()
        .font(.system(size: 18))
        .foregroundStyle(.white)
        .frame(width: 350, height: 200)
        .background(.white.quinary)
        .clipShape(.rect(cornerRadius: 15))
    }
}

struct MortgageEntriesView : View {
    @Binding var loanAmount : String
    
    @State var interestRate : String = ""
    @State var numPayments : String = ""
    
    @State var isYears : Bool = true
    
    @Binding var monthlyPayments : Double
    @Binding var totalInterestPaid : Double
    
    var body : some View {
        VStack {
            Text("Loan Amount")
            HStack {
                Text("$")
                TextField("5,000", text: $loanAmount)
            }
            .padding()
            .frame(height: 40)
            .background(.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
            
            Text("Loan term")
            HStack {
                VStack {
                    TextField("\(isYears ? "5" : "60")", text: $numPayments)
                        .keyboardType(.decimalPad)
                }
                .padding()
                .frame(width: 150, height: 40)
                .background(.gray.opacity(0.4))
                .clipShape(.rect(cornerRadius: 5))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                
                HStack {
                    Button(action: { isYears = true }) {
                        Text("Years")
                            .frame(maxWidth: .infinity) // Ensures equal spacing
                            .background(isYears ? Color.gray.opacity(0.4) : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    
                    Divider()
                    
                    Button(action: { isYears = false }) {
                        Text("Months")
                            .frame(maxWidth: .infinity)
                            .background(!isYears ? Color.gray.opacity(0.4) : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                .foregroundStyle(.white)
                .padding(5)
                .frame(width: 150, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white, lineWidth: 1))
            }
            
            Text("Interest rate")
            HStack {
                HStack {
                    TextField("4.5", text: $interestRate)
                    Text("%")
                }
                .padding()
                .frame(width: 200, height: 40)
                .background(.gray.opacity(0.4))
                .clipShape(.rect(cornerRadius: 5))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                
                Button(
                    action: {
                        calculateTotal()
                    },
                    label: {
                        Text("Calculate")
                            .frame(width: 100, height: 40)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 5))
                    }
                )
            }
        }
        .padding()
        .frame(width: 350, height: 400)
        .background(.white.quinary)
        .clipShape(.rect(cornerRadius: 15))
    }
    
    func calculateTotal() {
        guard let p = Double(loanAmount), let rate = Double(interestRate) else {
            monthlyPayments = 0
            return
        }

        let i = rate / 100 / 12  // Convert annual interest rate to monthly decimal form
        let n: Int

        if isYears {
            n = Int(12 * (Double(numPayments) ?? 5))  // Convert years to months
        } else {
            n = Int(Double(numPayments) ?? 60)  // Directly use months
        }

        monthlyPayments = calculatePayment(p: p, i: i, n: n) ?? 0
        totalInterestPaid = (monthlyPayments * Double(n)) - p
    }

    func calculatePayment(p: Double, i: Double, n: Int) -> Double? {
        guard i > 0, n > 0 else { return nil } // Prevent division by zero

        let numerator = i * pow(1 + i, Double(n))
        let denominator = pow(1 + i, Double(n)) - 1

        guard denominator != 0 else { return nil } // Prevent division by zero

        return p * (numerator / denominator)
    }
}

#Preview {
    MortgageCalculator()
}
