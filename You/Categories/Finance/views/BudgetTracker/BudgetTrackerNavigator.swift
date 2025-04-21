//
//  BudgetTrackerNavigator.swift
//  You
//
//  Created by Oliver Gilcher on 3/6/25.
//

import SwiftUI

struct BudgetTrackerNavigator: View {
    @StateObject private var viewModel = BudgetTrackerViewModel()
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Graphs", systemImage: "house") {
                    BudgetTrackerView(viewModel: viewModel).navigationBarBackButtonHidden(true)
                }
                Tab("Budget", systemImage: "mail.stack.fill") {
                    BudgetView(viewModel: viewModel).navigationBarBackButtonHidden(true)
                }
                Tab("Back", systemImage: "arrow.left.circle.fill") {
                    FinanceLanding().navigationBarBackButtonHidden(true)
                        .toolbarVisibility(.hidden, for: .tabBar)
                }
                Tab("Transactions", systemImage: "dollarsign.circle.fill") {
                    BudgetTransactionsView(viewModel: viewModel).navigationBarBackButtonHidden(true)
                }
            }
            .onAppear {
                viewModel.load(forMonth: Date.now.formatted(.dateTime.month()))
            }
        }
    }
}

#Preview {
    BudgetTrackerNavigator()
}
