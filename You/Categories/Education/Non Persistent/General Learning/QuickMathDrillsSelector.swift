//
//  QuickMathDrills.swift
//  You
//
//  Created by Oliver Gilcher on 2/3/25.
//

import SwiftUI

struct QuickMathDrills: View {
    @AppStorage("backgroundColor") private var backgroundColor : String?
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 40) {
                QuickMathDrillsHeader()
                    .padding(.top, 75)
                
                NavigationLink(
                    destination: QuickMathView(mathType: "Easy").navigationBarBackButtonHidden(true),
                    label: {
                        HStack {
                            Image(systemName: "plusminus")
                                .font(.system(size: 40, weight: .bold))
                                .frame(width: 100, height: 100)
                                .background(.green)
                                .clipShape(.ellipse)
                            
                            Spacer()
                                
                            VStack (spacing: 10) {
                                Text("Easy")
                                    .font(.system(size: 25, weight: .semibold))
                                Text("Simple addition, subtraction, multiplication, division, and basic fractions.")
                                    .font(.system(size: 18))
                            }
                        }
                    }
                )
                
                NavigationLink(
                    destination: QuickMathView(mathType: "Medium").navigationBarBackButtonHidden(true),
                    label: {
                        HStack {
                            Image(systemName: "x.squareroot")
                                .font(.system(size: 40, weight: .bold))
                                .frame(width: 100, height: 100)
                                .background(.yellow)
                                .clipShape(.ellipse)
                            
                            Spacer()
                                
                            VStack (spacing: 10) {
                                Text("Medium")
                                    .font(.system(size: 25, weight: .semibold))
                                Text("Multi-step problems, exponents, square roots, order of operations, and basic probability.")
                                    .font(.system(size: 18))
                            }
                        }
                    }
                )
                
                NavigationLink(
                    destination: QuickMathView(mathType: "Hard").navigationBarBackButtonHidden(true),
                    label: {
                        HStack {
                            Image(systemName: "function")
                                .font(.system(size: 40, weight: .bold))
                                .frame(width: 100, height: 100)
                                .background(.red)
                                .clipShape(.ellipse)
                            
                            Spacer()
                                
                            VStack (spacing: 10) {
                                Text("Hard")
                                    .font(.system(size: 25, weight: .semibold))
                                Text("Algebra, geometry, trigonometry, functions, and complex probability problems.")
                                    .font(.system(size: 18))
                            }
                        }
                    }
                )
                
                NavigationLink(
                    destination: QuickMathView(mathType: "Expert").navigationBarBackButtonHidden(true),
                    label: {
                        HStack {
                            Image(systemName: "trophy")
                                .font(.system(size: 40, weight: .bold))
                                .frame(width: 100, height: 100)
                                .background(.black)
                                .clipShape(.ellipse)
                            
                            Spacer()
                                
                            VStack (spacing: 10) {
                                Text("Expert")
                                    .font(.system(size: 25, weight: .semibold))
                                Text("Calculus, logarithms, linear algebra, advanced statistics, and infinite series.")
                                    .font(.system(size: 18))
                            }
                        }
                    }
                )
                
                Spacer()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .ignoresSafeArea()
            .background(Color.fromString(from: backgroundColor).gradient)
        }
    }
}

struct QuickMathDrillsHeader : View {
    var body : some View {
        HStack {
            NavigationLink(
                destination: HomeScreen().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "chevron.left")
                }
            )
            Spacer()
            Text("Quick Math Drills")
            Spacer()
        }
        .font(.system(size: 25, weight: .bold))
    }
}

#Preview {
    QuickMathDrills()
}
