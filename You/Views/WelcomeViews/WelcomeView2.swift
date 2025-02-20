//
//  WelcomeView2.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI
import SwiftData

// App-setup View that handles AppCategory selection
struct WelcomeView2 : View {
    @Environment(\.dismiss) private var dismiss // Dismiss view
    @Environment(\.modelContext) var context // Data storage context
    
    private var allCategories : [AppCategory] = AppCategoryManager.shared.getAppCategories() // List of all available app categories
    private let columns = Array(repeating: GridItem(.flexible()), count: 2) // Columns attribute for use in LazyVGrid
    
    var body : some View {
        NavigationView {
            VStack (spacing: 20) {
                
                VStack { // Title
                    Text("How can I be")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("of your assistance?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 25, weight: .bold))
                
                VStack (spacing: 5) { // Subtitle
                    Text("Please choose up to 10 categories,")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("you can always change your preferences later.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 18))
                .foregroundStyle(.white.opacity(0.8))
                
                Spacer()
                
                ScrollView { // List of categories
                    LazyVGrid(columns: columns) {
                        ForEach(allCategories, id:\.self) { category in
                            CategorySelectionButton(appCategory: category)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink ( // Continue Button
                    destination: WelcomeView3().navigationBarBackButtonHidden(true),
                    label: {
                        Text("Continue")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 55)
                            .background(.blue)
                            .clipShape(.capsule)
                    }
                )
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        Task {
                            // Save the context when done
                            try context.save()
                        }
                    }
                )
            }
            .toolbar {
                // Back button
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
                // Custom progress bar
                ToolbarItemGroup(placement: .principal) {
                    ProgressView(value: 2, total: 6)
                        .progressViewStyle(CustomProgressViewStyle(height: 15))
                        .frame(width: 300)
                }
            }
            .onAppear {
                let appCategoryType = AppCategoryManager.AppCategoryType.self
                context.insert(appCategoryType.finance.details)
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.voidBlack.gradient)
        }
    }
}

// Selection button for categories
struct CategorySelectionButton : View {
    @Environment(\.modelContext) var context // Data storage context
    @Query(sort: \AppCategory.title) var selectedCategories: [AppCategory] // Data model of stored 'selectedCategories'
    
    var appCategory: AppCategory // param: app category we wish to use
    
    var body : some View {
        Button (
            action: {
                if selectedCategories.contains(appCategory) {
                    if let index = selectedCategories.firstIndex(of: appCategory) {
                        context.delete(selectedCategories[index])
                    }
                } else {
                    context.insert(appCategory)
                }
            },
            label: {
                HStack {
                    Text(appCategory.title) // App category's title
                    Spacer()
                    Image(systemName: selectedCategories.contains(appCategory) ? "checkmark.circle" : "circle") // Indicator of selection
                }
                .padding()
                .foregroundStyle(.white)
                .frame(width: 150, height: 45)
                .background(Color.fromString(from: appCategory.color))
                .clipShape(.rect(cornerRadius: 10))
            }
        )
    }
}

#Preview {
    NavigationStack {
        WelcomeView2()
    }
}
