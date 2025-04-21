//
//  LandingUtil.swift
//  You
//
//  Created by Oliver Gilcher on 1/28/25.
//

import SwiftUI

struct LandingHeader : View {
    var title : String
    var view : AnyView
    var previousView = HomeScreen()
    
    var body : some View {
        HStack {
            NavigationLink(
                destination: previousView.navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "chevron.left")
                }
            )
            
            Spacer()
            
            Text(title)
            
            Spacer()
            
            NavigationLink (
                destination: SettingsView().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "line.3.horizontal")
                }
            )
        }
        .font(.system(size: 25, weight: .bold))
        .foregroundStyle(.white)
    }
}

struct LandingPageFeatured : View {
    var title: String
    var image1: String
    var image2: String
    var image3: String
    var description: String
    var destination: AnyView
    
    var body : some View {
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
                Image(systemName: image1)
                Image(systemName: image2)
                Image(systemName: image3)
            }
            .foregroundStyle(.white)
            .font(.system(size: 20, weight: .bold))
            
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .bold))
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
                .font(.system(size: 12))
            
            NavigationLink(
                destination: destination.navigationBarBackButtonHidden(true),
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
        
    }
}

struct LandingPagePinned : View {
    @Binding var pinnedApps : [String]
    @Binding var isSheetPresented : Bool
    
    var body : some View {
        VStack {
            HStack {
                Text("Pinned")
                    .foregroundStyle(.white)
                Spacer()
                Button(
                    action: {
                        isSheetPresented = true
                    },
                    label: {
                        Text("Edit")
                    }
                )
            }
            .font(.system(size: 18, weight: .semibold))
            
            ForEach(0..<pinnedApps.count, id: \.self) {index in
                MediumCard(subApp: AppCategoryManager.shared.getSubApp(for: pinnedApps[index]))
            }
        }
        
    }
}

struct LandingPageExplore: View {
    @Binding var pinnedApps: [String]
    var parentName: String

    var body: some View {
        let filteredApps = AppCategoryManager.shared.getSubApps(for: parentName).filter { !pinnedApps.contains($0) }

        VStack {
            HStack {
                Text("Explore")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }
            
            ForEach(filteredApps, id: \.self) { app in
                MediumCard(subApp: AppCategoryManager.shared.getSubApp(for: app))
            }
        }
    }
}

struct LandingPagePinnedEditor : View {
    @Binding var pinnedApps : [String]
    @State var newPinnedApps : [String] = []
    @State private var allApps : [String] = []
    
    @Binding var isPresented : Bool
    @State private var searchText = ""
    var parentName : String
    
    var body : some View {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("Edit List")
                Spacer()
                Button(
                    action: {
                        pinnedApps = newPinnedApps
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
                    TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                    }, onCommit: {
                        print("onCommit")
                    }).foregroundColor(.primary)
                    Button (action: { self.searchText = "" },
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
            
            Text("Pinned")
            List {
                ForEach(newPinnedApps.indices, id: \.self) { index in
                    if (newPinnedApps[index].contains(searchText) || searchText.isEmpty) {
                        PinnedElement(name: newPinnedApps[index], pinnedApps: $newPinnedApps)
                    }
                }
            }
            
            Text("Remaining")
            List {
                ForEach(allApps.indices, id: \.self) { index in
                    if !newPinnedApps.contains(allApps[index]) && (allApps[index].contains(searchText) || searchText.isEmpty) {
                        UnpinnedElement(name: allApps[index], pinnedApps: $newPinnedApps)
                    }
                }
            }
        }
        .onAppear {
            allApps = AppCategoryManager.shared.getSubApps(for: parentName)
            newPinnedApps = pinnedApps
        }
    }
}

struct PinnedElement: View {
    var name: String
    @Binding var pinnedApps: [String]
    
    var body: some View {
        Button(
            action: {
                if let index = pinnedApps.firstIndex(of: name) {
                    pinnedApps.remove(at: index)
                }
            },
            label: {
                HStack(spacing: 20) {
                    Image(systemName: "pin.fill")
                        .foregroundStyle(.red)
                    Text(name)
                    Spacer()
                }
            }
        )
    }
}

struct UnpinnedElement : View {
    var name : String
    @Binding var pinnedApps: [String]
    
    var body : some View {
        Button(
            action: {
                pinnedApps.append(name)
            },
            label: {
                HStack(spacing: 20) {
                    Image(systemName: "pin.fill")
                        .foregroundStyle(.yellow)
                    Text(name)
                    Spacer()
                }
            }
        )
    }
}

struct MediumCard : View {
    var subApp : SubApp
    
    var body : some View {
        NavigationLink(destination: subApp.destination.navigationBarBackButtonHidden(), label: {
            VStack (spacing: 15) {
                // Top Row - logo, title, destination
                HStack {
                    Image(systemName: subApp.image1)
                    Text(subApp.title)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(subApp.color)
                // Bottom Row - description, second image (optional)
                HStack {
                    Text(subApp.description ?? "")
                    Spacer()
                    if (subApp.image2 != nil) {
                        Image(systemName: subApp.image2!)
                            .font(.system(size: 25))
                    }
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.gray)
            }
            .frame(width: 300, height: 70)
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 15))
        })
    }
}
