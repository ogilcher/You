//
//  BudgetTransactions.swift
//  You
//
//  Created by Oliver Gilcher on 3/6/25.
//

import SwiftUI

struct BudgetTransactionsView: View {
    @ObservedObject var viewModel: BudgetTrackerViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .padding()
            .foregroundStyle(.white)
            .font(.system(size: 20))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.voidBlack.gradient)
        }
    }
}

#Preview {
    @StateObject @Previewable var viewModel = BudgetTrackerViewModel()
    
    NavigationStack {
        BudgetTransactionsView(viewModel: viewModel)
    }
}
