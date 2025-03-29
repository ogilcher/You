//
//  Finance_Landing.swift
//  You
//
//  Created by Oliver Gilcher on 1/28/25.
//

import SwiftUI

struct Finance_Landing : View {
    @Environment(\.dismiss) private var dismiss
    @State var isSheetPresented : Bool = false
    @State var testPinnedApps = ["mortgageCalculator", "tipCalculator"]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack (spacing: 10) {
                        VStack (spacing: 10) {
                            Text("Featured")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.gray)
                                .frame(width: 80, height: 25)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 5)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.gray, lineWidth: 1)
                                )
                            HStack (spacing: 40) {
                                Image(systemName: "chart.bar.xaxis")
                                Image(systemName: "candybarphone")
                                Image(systemName: "dollarsign.guage.chart.leftthird.topthird.rightthird")
                            }
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .bold))
                            
                            Text("Budgeting and Fiance Tracker")
                                .foregroundStyle(.white)
                                .font(.system(size: 20, weight: .bold))
                            
                            Text("Tracks income, expenses, and savings to manage finances efficiently.")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.gray)
                                .font(.system(size: 12))
                            
                            NavigationLink(
                                destination: BudgetTrackerNavigator().navigationBarBackButtonHidden(true),
                                label: {
                                    HStack {
                                        Image(systemName: "lock.fill")
                                        Text("Open")
                                    }
                                    .frame(width: 120, height: 40)
                                    .foregroundStyle(.white)
                                    .background(.blue)
                                    .clipShape(.rect(cornerRadius: 25))
                                }
                            )
                        }
                        
                        Divider()
                        
                        LandingPagePinned(pinnedApps: $testPinnedApps, isSheetPresented: $isSheetPresented)
                        
                        Divider()
                        
                        LandingPageExplore(pinnedApps: $testPinnedApps, parentName: "Finanace")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.voidBlack)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
            }
            .padding()
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(.voidBlack.gradient)
            .navigationTitle("Finance")
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
            .sheet(isPresented: $isSheetPresented) {
                LandingPagePinnedEditor(pinnedApps: $testPinnedApps, isPresented: $isSheetPresented, parentName: "Finance")
            }
        }
    }
}

#Preview {
    NavigationStack {
        Finance_Landing()
    }
}
