//
//  WelcomeView2.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI
import SwiftData

struct WelcomeView2 : View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    var allCategories : [AppCategory] = AppCategoryManager.shared.getAppCategories()
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body : some View {
        NavigationView {
            VStack (spacing: 20) {
                VStack {
                    Text("How can I be")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("of your assistance?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 150)
                .font(.system(size: 25, weight: .bold))
                
                VStack (spacing: 5) {
                    Text("Please choose up to 10 categories,")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("you can always change your preferences later.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 16))
                .foregroundStyle(.white.opacity(0.8))
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(allCategories, id:\.self) { category in
                            CategorySelectionButton(appCategory: category)
                        }
                    }
                }
                
                NavigationLink(
                    destination: WelcomeView3().navigationBarBackButtonHidden(),
                    label: {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 350, height: 55)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 45))
                    }
                )
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        Task {
                            try context.save()
                        }
                    }
                )
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
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
            
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(.voidBlack.gradient) // TODO: Make the custom color (dark blue)
            .ignoresSafeArea()
        }
    }
}

struct CategorySelectionButton : View {
    @Environment(\.modelContext) var context
    
    @Query(sort: \AppCategory.title) var selectedCategories: [AppCategory]
    var appCategory: AppCategory
    
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
                    Text(appCategory.title)
                    Spacer()
                    Image(systemName: selectedCategories.contains(appCategory) ? "checkmark.circle" : "circle")
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
