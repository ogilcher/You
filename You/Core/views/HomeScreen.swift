//
//  HomeScreen.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI
import SwiftData

struct HomeScreen : View {
    @State private var username: String?
    @StateObject private var viewModel = HomeScreenViewModel()
    @State private var welcomeMessage = ""
        
    var body: some View {
        NavigationStack {
            VStack (spacing: 40) {
                HomeScreenHeader()
                    .padding(.top, 75)
                
                Text(welcomeMessage)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                
                NotificationBar()
                
                Spacer()
                
                CircleView()
                    
            }.onAppear {
                self.username = viewModel.user?.fName ?? ""
                welcomeMessage = getRandomWelcomeMessage()
            }
            .task {
                try? await viewModel.loadCurrentUser()
            }
            .foregroundStyle(.white)
            .font(.system(size: 20))
            .frame(
                maxWidth: .infinity, maxHeight: .infinity
            )
            .ignoresSafeArea()
            .padding(.horizontal)
            .background(LinearGradient(colors: [.color1, .color2], startPoint: .top, endPoint: .bottom))
        }
    }
    
    func getRandomWelcomeMessage() -> String {
        let welcomeMessages = [
            "Welcome aboard \(username ?? "")! Let's make today amazing.",
            "Hey there, \(username ?? "")! Ready to dive into something awesome?",
            "Hello, \(username ?? "")! We’re so glad you’re here—let’s get started!",
            "Welcome, \(username ?? "")! Your journey begins now.",
            "Hi, \(username ?? "")! Let’s create something great together.",
            "It’s great to see you, \(username ?? "")! Let’s make this moment count.",
            "Hey, \(username ?? "")! Ready to explore what we’ve got for you?",
            "Welcome back, \(username ?? "")! Let’s pick up where we left off.",
            "Hello, \(username ?? "")! Let’s get you set up for success.",
            "Glad to have you here, \(username ?? "")! Let’s make it a memorable experience."
        ]
        
        return welcomeMessages[Int.random(in: 0..<welcomeMessages.count)]
    }
}

struct HomeScreenHeader : View {
    var body : some View {
        HStack {
            NavigationLink(
                destination: AllCategoriesView().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "circle.hexagongrid")
                }
            )
            Spacer()
            NavigationLink(
                destination: SettingsView().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "line.3.horizontal")
                }
            )
        }
        .font(.system(size: 20, weight: .semibold))
        .foregroundStyle(.white)
    }
}

struct NotificationBar : View {
    
    var body : some View {
        TabView {
            Text("You have 1 notification")
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        
        .frame(width: 350, height: 225)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(.clear)
                .stroke(.ultraThickMaterial, lineWidth: 4)
        )
    }
}

struct CircleView : View {
    var distance: CGFloat = 140.0 // the distance between buttons
    var buttonHeight: CGFloat = 55.0
    
    // How far along the icons go
    var startAngle: Double = 0.0
    var endAngle: Double = 120.0
    
    //-- Center Button Animations
    
    // Plus Button (creates rotation effect for button)
    @State private var plusDegrees: Double = 0.0
    // Creates opacity effect for button after rotating it
    @State private var plusOpacity: Double = 1.0
    @State private var plusScale: Bool = false
    // Throttles interval at which button can be pressed
    @State private var isBounceAnimating: Bool = false
    
    //-- Item Button Animations
    @State private var isDistance: Double = 0.0
    
    @Environment(\.modelContext) var context
    @Query(sort: \AppCategory.title) var selectedCategories: [AppCategory]
    
    var body : some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .fill(.clear)
                    .frame(
                        width: distance*2 + buttonHeight,
                        height: distance*2 + buttonHeight
                    )
                    .overlay {
                        ZStack {
                            plusView()
                            
                            ForEach(selectedCategories) { category in
                                itemView(category)
                            }
                        }
                    }
            }
            .onAppear {
                updateItems()
            }
        }
    }
    
    fileprivate func updateItems() {
        let step = getStep()
        
        for i in 0..<selectedCategories.count {
            let angle: Double = startAngle + Double(i) * step
            
            selectedCategories[i].itemID = i
            selectedCategories[i].angle = angle
        }
    }
    
    // Handles spacing and angle logic
    fileprivate func getStep() -> Double {
        var length = endAngle - startAngle
        var count = selectedCategories.count
        
        if length < endAngle {
            count -= 1
        } else if length > endAngle {
            length = endAngle
        }
        
        return length / Double(count)
    }
}

// Handles Circle Logic
extension CircleView {
    
    @ViewBuilder
    private func plusView() -> some View {
        Button {
            // Stops the user from registering clicks while
            // animation is running
            guard !isBounceAnimating else {
                return
            }
            
            isBounceAnimating = true
            
            print("You pressed me!")
            for cat in selectedCategories {
                print(cat.title)
            }
            plusDidTap()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: buttonHeight, height: buttonHeight)
                .clipShape(.rect(cornerRadius: buttonHeight/2))
                .foregroundStyle(.white)
        }
        .zIndex(5)
        .rotationEffect(.degrees(plusDegrees))
        .scaleEffect(plusScale ? 0.9 : 1.0)
        .opacity(plusOpacity)
    }
    
    // Runs when the button is tapped
    fileprivate func plusDidTap() {
        // Toggles the scale
        plusScale.toggle()
        
        // Spring animation for rotation, opacity and scale
        withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
            plusDegrees = plusDegrees == 45 ? 0 : 45
            plusOpacity = plusDegrees == 45 ? 0.4 : 1.0
            
            // Create bounce animation once tapped
            plusScale.toggle()
            
            isDistance = plusDegrees == 45 ? distance : 0.0
        } completion: {
            // Toggles off bounceAnimating when animation
            // is finished running
            isBounceAnimating = false
        }
    }
}

// Logic for items in the
extension CircleView {
    
    @ViewBuilder
    private func itemView(_ item: AppCategory) -> some View {
        RoundedRectangle(cornerRadius: buttonHeight/2)
            .fill(.stardustPink)
            .frame(width: buttonHeight, height: buttonHeight)
            .overlay {
                NavigationLink (
                    destination: AnyView.fromString(for: item.destination).navigationBarBackButtonHidden(true),
                    label: {
                        Image(systemName: item.image)
                            .frame(width: buttonHeight,
                                   height: buttonHeight)
                            .tint(.white)
                            .background(Color.fromString(from: item.color))
                            .clipShape(.rect(cornerRadius:
                                                buttonHeight/2))
                    }
                ).rotationEffect(.degrees(-item.angle))
            }
            .offset(x: -isDistance)
            .rotationEffect(.degrees(item.angle))
            .scaleEffect(isDistance == 0 ? 0.0 : 1.0)
            .opacity(isDistance == 0 ? 0.0 : 1.0)
    }
}


#Preview {
    HomeScreen()
}
