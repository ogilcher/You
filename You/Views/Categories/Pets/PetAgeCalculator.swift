//
//  PetAgeCalculator.swift
//  You
//
//  Created by Oliver Gilcher on 1/29/25.
//

import SwiftUI

final class PetAgeCalculatorViewModel : ObservableObject {
    @Published var smallDogAges : [Int] = [15, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80]
    @Published var mediumDogAges : [Int] = [15, 24, 28, 32, 36, 42, 47, 51, 56, 60, 65, 69, 74, 78, 83, 87]
    @Published var largeDogAges : [Int] = [15, 24, 28, 32, 36, 45, 50, 55, 61, 66, 72, 77, 82, 88, 93, 99]
    @Published var giantDogAges : [Int] = [12, 22, 31, 38, 45, 49, 56, 64, 71, 79, 86, 93, 100, 107, 114, 121]
    @Published var catAges : [Int] = [15, 24, 28, 32, 36, 42, 47, 51, 56, 60, 65, 69, 74, 78, 83, 87]
}

struct PetAgeCalculator : View {
    @AppStorage("backgroundColor") var backgroundColor : String?
    @Environment(\.dismiss) private var dismiss
    
    @State var isDog : Bool = true
    @State var dogSize : String = "small"
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 40) {
                HStack {
                    Spacer()
                    Button (
                        action: {
                            isDog = true
                        }, label: {
                            HStack {
                                Image(systemName: "dog.fill")
                                Text("Dog")
                            }
                        }
                    )
                    .frame(width: 150, height: 55)
                    .background(isDog ? Color.white.opacity(0.4) : Color.clear)
                    .clipShape(.rect(cornerRadius: 20))
                    Spacer()
                    Button (
                        action: {
                            isDog = false
                        }, label : {
                            HStack {
                                Image(systemName: "cat.fill")
                                Text("Cat")
                            }
                        }
                    )
                    .frame(width: 150, height: 55)
                    .background(!isDog ? Color.white.opacity(0.4) : Color.clear)
                    .clipShape(.rect(cornerRadius: 20))
                    Spacer()
                }
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 300, height: 55)
                .clipShape(.rect(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white.quinary, lineWidth: 2)
                )
                
                if isDog {
                    DogWeightPicker(dogSize: $dogSize)
                }
                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.fromString(from: backgroundColor).gradient)
        }
        .navigationTitle("Pet Age Calculator")
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

struct DogWeightPicker : View {
    @Binding var dogSize : String
    var weightButtonSize : CGFloat = 85
    
    var body : some View {
        HStack {
            Button (
                action: {
                    dogSize = "small"
                }, label: {
                    VStack {
                        Text("Small")
                        Text("< 20lbs")
                    }
                }
            )
            .frame(width: weightButtonSize, height: weightButtonSize)
            .background(dogSize.elementsEqual("small") ? Color.white.quinary.opacity(0.4) : Color.white.quinary.opacity(1))
            .clipShape(.rect(cornerRadius: 20))
            
            Button (
                action: {
                    dogSize = "medium"
                }, label: {
                    VStack {
                        Text("Medium")
                        Text("21-50 lbs")
                    }
                }
            )
            .frame(width: weightButtonSize, height: weightButtonSize)
            .background(dogSize.elementsEqual("medium") ? Color.white.quinary.opacity(0.4) : Color.white.quinary.opacity(1))
            .clipShape(.rect(cornerRadius: 20))
            
            Button (
                action: {
                    dogSize = "large"
                }, label: {
                    VStack {
                        Text("Large")
                        Text("51-100 lbs")
                    }
                }
            )
            .frame(width: weightButtonSize, height: weightButtonSize)
            .background(dogSize.elementsEqual("large") ? Color.white.quinary.opacity(0.4) : Color.white.quinary.opacity(1))
            .clipShape(.rect(cornerRadius: 20))
            
            Button (
                action: {
                    dogSize = "giant"
                }, label: {
                    VStack {
                        Text("Giant")
                        Text("100+ lbs")
                    }
                }
            )
            .frame(width: weightButtonSize, height: weightButtonSize)
            .background(dogSize.elementsEqual("giant") ? Color.white.quinary.opacity(0.4) : Color.white.quinary.opacity(1))
            .clipShape(.rect(cornerRadius: 20))
        }
        .foregroundStyle(.white)
        .font(.system(size: 16, weight: .semibold))
    }
}




#Preview {
    PetAgeCalculator()
}
