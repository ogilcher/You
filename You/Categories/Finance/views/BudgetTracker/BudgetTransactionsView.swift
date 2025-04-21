//
//  BudgetTransactions.swift
//  You
//
//  Created by Oliver Gilcher on 3/6/25.
//

import SwiftUI

struct BudgetTransactionsView: View {
    @ObservedObject var viewModel: BudgetTrackerViewModel
    @State var isShowingText : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isShowingText {
                    Text("You found me!")
                }
                Button {
                    isShowingText.toggle()
                } label: {
                    Text("Press me to \(isShowingText ? "hide" : "show")")
                }
                .frame(width: 200, height: 55)
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 15))
                
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
