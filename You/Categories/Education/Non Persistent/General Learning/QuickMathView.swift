//
//  QuickMathView.swift
//  You
//
//  Created by Oliver Gilcher on 2/3/25.
//

import SwiftUI

struct QuickMathView: View {
    @AppStorage("backgroundColor") private var backgroundColor : String?
    
    @State var mathType : String
    @State private var mathQuestions : [String : String] = [:]
    
    var body: some View {
        VStack {
            QuickMathViewHeader(mathType: $mathType)
                .padding(.top, 75)
            
            Spacer()
            
            TabView {
                ForEach(mathQuestions.keys.sorted(), id: \.self) { question in
                    QuestionCard(question: question, answer: mathQuestions[question]!)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            Spacer()
            
        }
        .onAppear{
            mathQuestions = MathQuestions().getQuestionType(difficulty: mathType)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .ignoresSafeArea()
        .background(Color.fromString(from: backgroundColor).gradient)
    }
}

struct QuestionCard : View {
    var question : String
    var answer : String
    
    @State private var isExpanded : Bool = false
    
    var body : some View {
        VStack (spacing: 40) {
            ZStack (alignment: .bottom) {
                Text(
                    "\(question) \(question.elementsEqual("Easy") ? "= ?" : "")"
                )
                .multilineTextAlignment(.center)
                .font(.system(size: question.count > 15 ? 40 : 30, weight: .semibold))
                .frame(width: 300, height: 300)
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 5, x: 5, y: 5)
                
                Button(
                    action: {
                        isExpanded.toggle()
                    },
                    label: {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.black)
                            .frame(width: 75, height: 75)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 20))
                            .shadow(radius: 5, x: 5, y: 5)
                    }
                )
                .padding(.bottom, -30)
            }
            .foregroundStyle(.white)
            
            if isExpanded {
                Text(answer)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30, weight: .semibold))
                    .frame(width: 300, height: 150)
                    .background(.white.quinary)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(radius: 5, x: 5, y: 5)
            }
        }
    }
}

struct QuickMathViewHeader : View {
    @Binding var mathType : String
    
    var body : some View {
        HStack {
            NavigationLink(
                destination: QuickMathDrills().navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "chevron.left")
                }
            )
            
            Spacer()
            Text(mathType)
            Spacer()
        }
        .font(.system(size: 25, weight: .bold))
        .foregroundStyle(.white)
    }
}

#Preview {
    QuickMathView(mathType: "Expert")
}
