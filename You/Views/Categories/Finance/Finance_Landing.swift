//
//  Finance_Landing.swift
//  You
//
//  Created by Oliver Gilcher on 1/28/25.
//

import SwiftUI

struct Finance_Landing : View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("backgroundColor") var backgroundColor: String?
    @State var isSheetPresented : Bool = false
    @State var testPinnedApps = ["mortgageCalculator", "tipCalculator"]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack (spacing: 10) {
                        LandingPageFeatured(title: "Budgeting and Finance Tracker", image1: "chart.bar.xaxis", image2: "candybarphone", image3: "dollarsign.gauge.chart.leftthird.topthird.rightthird", description: "Tracks income, expenses, and savings to manage finances efficiently.", destination: AnyView(HomeScreen()))
                        
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
                .background(Color.fromString(from: backgroundColor))
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
            }
            .padding()
            .padding(.top, 100)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.fromString(from: backgroundColor).gradient)
        }
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

#Preview {
    Finance_Landing()
}
