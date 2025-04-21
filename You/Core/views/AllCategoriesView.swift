//
//  AllCategoriesView.swift
//  You
//
//  Created by Oliver Gilcher on 2/4/25.
//

import SwiftUI
import SwiftData

struct AllCategoriesView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) var context
    @Query(sort: \AppCategory.title) var selectedCategories: [AppCategory]
    
    @State var isSheetPresented : Bool = false
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 30) {
                Text("Selected Categories")
                    .font(.system(size: 20, weight: .semibold))
                VStack {
                    HStack {
                        Spacer()
                        Button (
                            action: {
                                isSheetPresented = true
                            },
                            label: {
                                Text("Edit")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.trailing, 20)
                            }
                        )
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(selectedCategories) { category in
                                SelectedCategoryButton(category: category)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 350, height: 60)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.ultraThickMaterial, lineWidth: 4)
                    )
                }
                
                Text("All Categories")
                    .font(.system(size: 20, weight: .semibold))
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(AppCategoryManager.shared.getAppCategories()) { category in
                        CategoryButton(category: category)
                    }
                }
                .padding()
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.ultraThickMaterial, lineWidth: 4)
                )
            }
            .foregroundStyle(.white)
            .font(.system(size: 20))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(LinearGradient(colors: [.color1, .color2], startPoint: .top, endPoint: .bottom))
            
            .sheet(isPresented: $isSheetPresented) {
                CategoryEditor(isPresented: $isSheetPresented)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(
                        action: {dismiss()},
                        label: {Image(systemName: "chevron.left")}
                    )
                }
                ToolbarItemGroup(placement: .principal) {
                    Text("Category Selector")
                }
            }
            .foregroundStyle(.white)
            .font(.system(size: 20, weight: .semibold))
        }
    }
}

struct CategoryEditor : View {
    @Environment(\.modelContext) var context
    @Query(sort: \AppCategory.title) var selectedCategories: [AppCategory]
    
    var allCategories : [AppCategory] = AppCategoryManager.shared.getAppCategories()
    
    @Binding var isPresented : Bool
    @State var searchText = ""
    
    var body : some View {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("Edit List")
                Spacer()
                Button(
                    action: {
                        do {
                            try context.save()
                        } catch {
                            print(error)
                        }
                        isPresented = false
                    },
                    label: {
                        Text("Done")
                    }
                )
            }
            // Search bar
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText, onEditingChanged: {
                        isEditing in
                    }, onCommit: {
                        print("onCommit")
                    }).foregroundStyle(.primary)
                    Button(
                        action: {
                            self.searchText = ""
                        },
                        label: {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    )
                }
                .padding()
                .frame(width: 350, height: 40)
                .background(.ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 15))
            }
            // Selected List
            Text("Selected")
            List {
                ForEach(selectedCategories) { category in
                    Button(
                        action: {
                            if let index = selectedCategories.firstIndex(of: category) {
                                context.delete(selectedCategories[index])
                            }
                        },
                        label: {
                            HStack (spacing: 20) {
                                Image(systemName: "pin.fill")
                                    .foregroundStyle(.red)
                                Text(category.title)
                                Spacer()
                            }
                        }
                    )
                }
            }
            // Remaining List
            Text("Remaining")
            List {
                ForEach(0..<allCategories.count, id: \.self) { index in
                    if !selectedCategories.contains(where: { $0.title == allCategories[index].title }) {
                        Button(
                            action: {
                                let newCategory = AppCategory(
                                    title: allCategories[index].title,
                                    image: allCategories[index].image,
                                    color: allCategories[index].color,
                                    destination: allCategories[index].destination
                                )
                                context.insert(newCategory) //  Insert new instance instead of modifying query result
                            },
                            label: {
                                HStack(spacing: 20) {
                                    Image(systemName: "pin.fill")
                                        .foregroundStyle(.yellow)
                                    Text(allCategories[index].title)
                                    Spacer()
                                }
                            }
                        )
                    }
                }
            }
        }
    }
}

struct SelectedCategoryButton : View {
    var category : AppCategory
    
    var body : some View {
        NavigationLink(
            destination: AnyView.fromString(for: category.destination).navigationBarBackButtonHidden(),
            label: {
                Image(systemName: category.image)
                    .clipShape(Ellipse())
                    .frame(width: 55, height: 55)
                    .background(Color.fromString(from: category.color))
                    .foregroundStyle(.white)
            }
        )
    }
}

struct CategoryButton: View {
    var category : AppCategory
    
    var body : some View {
        NavigationLink(
            destination:
                AnyView.fromString(for: category.destination).navigationBarBackButtonHidden(),
            label: {
                HStack {
                    Image(systemName: category.image)
                    Text(category.title)
                }
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .semibold))
                
                .padding()
                .frame(width: 150, height: 40)
                .background(Color.fromString(from: category.color))
                .clipShape(.rect(cornerRadius: 10))
            }
        )
    }
}

#Preview {
    AllCategoriesView()
}
