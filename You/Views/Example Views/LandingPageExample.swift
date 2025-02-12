//
//  LandingPageExample.swift
//  You
//
//  Created by Oliver Gilcher on 2/4/25.
//

import SwiftUI

struct LandingPageExample: View {
    @State var isSheetPresented : Bool = false
    @State var testPinnedApps = ["mortgageCalculator", "tipCalculator"]
    
    var body: some View {
        NavigationStack {
            VStack {
                LandingPageExampleHeader()
                    .padding(.top, 75)
                
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
                .background(Color.fromString(from: "voidBlack"))
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.fromString(from: "voidBlack").gradient)
        }
        .sheet(isPresented: $isSheetPresented) {
            LandingPagePinnedEditor(pinnedApps: $testPinnedApps, isPresented: $isSheetPresented, parentName: "Finance")
        }
    }
}

struct LandingPageExampleHeader : View {
    var body : some View {
        HStack {
            Image(systemName: "chevron.left")
            Spacer()
            Text("Finance")
                .fontWeight(.bold)
            Spacer()
        }
        .font(.system(size: 20))
    }
}

struct LandingPageExampleDiscover : View {
    var body : some View {
        VStack {
            HStack {
                Text("Discover")
                Spacer()
            }
        }
    }
}



#Preview {
    LandingPageExample()
}
