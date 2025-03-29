//
//  Skeleton.swift
//  You
//
//  Created by Oliver Gilcher on 2/16/25.
//

import Foundation
import SwiftUI

public extension View {
    func skeleton<S>(
        _ shape: S? = nil as Rectangle?,
        isLoading: Bool
    ) -> some View where S: Shape {
        guard isLoading else { return AnyView(self) }
        let skeletonColor = Color.gray.opacity(0.3)
        
        let skeletonShape: AnyShape = if let shape {
            AnyShape(shape)
        } else {
            AnyShape(Rectangle())
        }
        
        return AnyView(
            opacity(0)
                .overlay(skeletonShape.fill(skeletonColor))
                .shimmering()
        )
    }
    
    func shimmering() -> some View {
        modifier(ShimmeringModifier())
    }
}

public struct ShimmeringModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    public func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedMask(phase: phase)
            )
            .onAppear {
                withAnimation(
                    .linear(duration: 2)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1
                }
            }
    }
    
    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat
        
        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }
        
        func body(content: Content) -> some View {
            content
                .mask(
                    GradientMask(phase: phase)
                        .scaleEffect(3)
                )
        }
    }
    
    struct GradientMask: View {
        let phase: CGFloat
        let centerColor = Color.gray.opacity(0.4)
        let edgeColor = Color.gray.opacity(1)
        
        var body : some View {
            GeometryReader { geometry in
                LinearGradient(
                    gradient:
                        Gradient(
                            stops: [
                                .init(color: edgeColor, location: phase),
                                .init(color: centerColor, location: phase + 0.1),
                                .init(color: edgeColor, location: phase + 0.2)
                            ]
                        ),
                    startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5)
                )
                .rotationEffect(.degrees(-45))
                .offset(x: -geometry.size.width, y: -geometry.size.height)
                .frame(width: geometry.size.width * 3, height: geometry.size.height * 3)
            }
        }
    }
}



