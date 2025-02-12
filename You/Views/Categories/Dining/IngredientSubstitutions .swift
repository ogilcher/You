//
//  IngredientSubstitutions .swift
//  You
//
//  Created by Oliver Gilcher on 1/29/25.
//

// TODO: Clean everything up, add tactiles, for the most part done

import SwiftUI

struct IngredientSubstitutions : View {
    @AppStorage("backgroundColor") var backgroundColor: String?
    
    var subList = Substitutions().substitutionList
    @State private var searchText = ""
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) {
                IngredientSubstitutionsHeader()
                
                // Search bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)
                        
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
                
                List {
                    ForEach(subList.indices, id: \.self) { index in
                        if subList[index].from.hasPrefix(searchText) || searchText.isEmpty {
                            SubstitutionElement(substitution: subList[index])
                        }
                    }
                }
                .padding(0)
                .frame(maxHeight: 600)
                .resignKeyboardOnDragGesture()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.fromString(from: backgroundColor).gradient)
        }
    }
}

struct SubstitutionElement : View {
    var substitution : Substitute
    
    var body : some View {
        HStack {
            Text(substitution.from)
            Text(substitution.fromAmount)
            
            Image(systemName: "arrow.left.arrow.right")
            
            Text(substitution.to)
            Text(substitution.toAmount)
        }
    }
}

struct IngredientSubstitutionsHeader : View {
    var body : some View {
        HStack {
            NavigationLink(
                destination: Finance_Landing().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "chevron.left")
                }
            )
            Spacer()
            Text("Ingredient Substitions")
            Spacer()
        }
        .font(.system(size: 25, weight: .bold))
        .foregroundStyle(.white)
    }
}

final class Substitutions : Identifiable {
    final var substitutionList : [Substitute] = [
        Substitute(f: "Baking soda", t: "Baking powder", fA: "1 tsp", tA: "4 tsp"),
        Substitute(f: "Cornstarch (as thickener)", t: "Flour", fA: "1 tbs", tA: "2 tbs"),
        Substitute(f: "Lemon juice", t: "Vinegar", fA: "1 tsp", tA: "1/2 tsp"),
        Substitute(f: "Garlic", t: "Garlic powder", fA: "1 clove", tA: "1/8 tsp"),
        Substitute(f: "Oil (for baking)", t: "Applesauce", fA: "1/2 cup", tA: "1/2 cup"),
        Substitute(f: "Beer", t: "Chicken broth", fA: "1 cup", tA: "1 cup"),
        Substitute(f: "Baking mix", t: "Pancake mix", fA: "1 cup", tA: "1 cup"),
        Substitute(f: "Coconut milk", t: "Whole milk", fA: "1 cup", tA: "1 cup"),
        Substitute(f: "Gelatin", t: "Agar", fA: "1 tbsp", tA: "2 tsp"),
        Substitute(f: "Cumin", t: "Chili powder", fA: "1 tbsp", tA: "1 tbsp"),
        Substitute(f: "Cream cheese", t: "Fat-free Ricotta cheese", fA: "1 cup", tA: "1 cup"),
        Substitute(f: "Beef broth", t: "Soy sauce + Water", fA: "1 cup", tA: "1 cup"),
        Substitute(f: "Chicken broth", t: "Soy sauce + Water", fA: "1 cup", tA: "1 cup"),
        // TODO: Add more
        //Substitute(f: "", t: "", fA: "", tA: "")
    ]
}

final class Substitute{
    var from : String // f
    var to : String // t
    var fromAmount : String // fa
    var toAmount : String // ta
    
    init(f: String, t: String, fA: String, tA: String) {
        from = f
        to = t
        fromAmount = fA
        toAmount = tA
    }
}

#Preview {
    IngredientSubstitutions()
}
