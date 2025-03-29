//
//  TipCalculator.swift
//  You
//
//  Created by Oliver Gilcher on 2/1/25.
//

import SwiftUI

struct TipCalculator: View {
//    @AppStorage("backgroundColor") private var backgroundColor : String?
    
    var tipPercentages = [5, 10, 15, 25, 50]
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State var cost: String = ""
    @State var tipAmount: Double = 10
    @State var numPeople: String = ""
    
    @State var tipPerPerson: Double = 0
    @State var totalPerPerson: Double = 0
    
    @State var isShowingTotal: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 40) {
                TipCalculatorHeader()
                    .padding(.top, 75)
                
                // cost (pre tip)
                HStack {
                    Text("$")
                    TextField("0.00", text: $cost)
                        .keyboardType(.numberPad)
                }
                .font(.system(size: 18, weight: .semibold))
                
                .padding()
                .frame(width: 350, height: 45)
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                )
                
                Text("Select tip %")
                LazyVGrid(columns: columns) {
                    ForEach(tipPercentages, id: \.self) { percentage in
                        TipButton(tipPercentage: percentage, tipAmount: $tipAmount)
                    }
                    CustomTipButton(tipAmount: $tipAmount)
                }
                
                Text("Number of people")
                HStack {
                    HStack {
                        Image(systemName: "person.2.fill")
                        TextField("1", text: $numPeople)
                            .keyboardType(.numberPad)
                    }
                    .padding()
                    .frame(width: 200, height: 45)
                    .background(.white.quinary)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    
                    Button(
                        action: {
                            calculateTotal()
                            isShowingTotal = true
                        },
                        label: {
                            Text("Calculate")
                        }
                    )
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                
                    .frame(width: 150, height: 45)
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .font(.system(size: 18, weight: .semibold))
                
                if isShowingTotal {
                    TipCalculatorTotal(tipPerPerson: $tipPerPerson, totalPerPerson: $totalPerPerson, isShowingTotal: $isShowingTotal)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.fromString(from: "voidBlack").gradient)
            
        }
    }
    
    func calculateTotal () {
        let totalCost = ((Double(cost) ?? 0) + ((Double(cost) ?? 0) * (tipAmount / 100)))
        
        tipPerPerson = ((Double(cost) ?? 0) * (tipAmount / 100)) / (Double(numPeople) ?? 1)
        
        totalPerPerson = totalCost / (Double(numPeople) ?? 1)
    }
}

struct TipButton : View {
    var tipPercentage : Int
    @Binding var tipAmount : Double
    
    var body : some View {
        Button(
            action: {
                tipAmount = Double(tipPercentage)
            },
            label: {
                Text("\(tipPercentage)%")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                
                    .frame(width: 150, height: 45)
                    .background(tipAmount == Double(tipPercentage) ? Color.blue.opacity(0.4) : Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
        )
    }
}

struct CustomTipButton : View {
    @State var customAmount : String = ""
    @Binding var tipAmount : Double
    
    var body : some View {
        HStack {
            TextField("Custom", text: $customAmount)
                .keyboardType(.numberPad)
                .onSubmit {
                    tipAmount = Double(customAmount) ?? 0
                }
            Text("\(customAmount.isEmpty ? "" : "%")")
        }
        .padding()
        .font(.system(size: 20, weight: .semibold))
        .foregroundStyle(.white)
    
        .frame(width: 150, height: 45)
        .background(tipAmount == Double(customAmount) ? Color.blue.opacity(0.4) : Color.blue.opacity(0.1))
        .clipShape(.rect(cornerRadius: 10))
    }
}

struct TipCalculatorHeader : View {
    var body : some View {
        HStack {
            NavigationLink(
                destination: Finance_Landing().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "chevron.left")
                }
            )
            Spacer()
            Text("Tip Calculator")
            Spacer()
        }
        .font(.system(size: 25, weight: .bold))
        .foregroundStyle(.white)
    }
}

struct TipCalculatorTotal : View {
    @Binding var tipPerPerson : Double
    @Binding var totalPerPerson : Double
    @Binding var isShowingTotal : Bool
    
    var body : some View {
        VStack {
            HStack (spacing: 100) {
                VStack {
                    Text("Tip Amount")
                        .font(.system(size: 20, weight: .semibold))
                    Text("/ person")
                        .font(.system(size: 16, weight: .semibold))
                }
                
                Text("$ \(String(format: "%.2f", tipPerPerson))")
                    .font(.system(size: 25, weight: .bold))
            }
            
            Divider()
            
            HStack (spacing: 100) {
                VStack {
                    Text("Total Amount")
                        .font(.system(size: 20, weight: .semibold))
                    Text("/ person")
                        .font(.system(size: 16, weight: .semibold))
                }
                
                Text("$ \(String(format: "%.2f", totalPerPerson))")
                    .font(.system(size: 25, weight: .bold))
            }
            
            Button (
                action: {
                    isShowingTotal = false
                },
                label: {
                    Text("Reset")
                }
            )
            .font(.system(size: 20, weight: .semibold))
            .frame(width: 150, height: 45)
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
        }
        .foregroundStyle(.white)
        .frame(width: 350, height: 200)
        .background(.white.quinary)
        .clipShape(.rect(cornerRadius: 10))
       
    }
    
}

#Preview {
    TipCalculator()
}
