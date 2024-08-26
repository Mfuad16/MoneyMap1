//
//  GraphView.swift
//  ExpenseTrackerApp
//
//  Created by Mohamed Fuad on 8/23/24.
//

import SwiftUI


struct GraphView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            AnimatedCardView()
        }
        .padding()
    }
}

struct AnimatedCardView: View {
    @State private var animationPhase: CGFloat = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 10)
            
            RoundedRectangle(cornerRadius: 20)
                
                .stroke(linearGradient, lineWidth: 3)
                .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: animationPhase)
        }
        .frame(width: 300, height: 200)
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                animationPhase += 1
            }
        }
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]),
            startPoint: UnitPoint(x: 0, y: animationPhase),
            endPoint: UnitPoint(x: 1, y: animationPhase + 1)
        )
    }
}





import SwiftUI

struct ThanosView: View {
    @State private var isDisintegrating = false
    @State private var particles: [(CGPoint, CGFloat)] = []
    
    var body: some View {
        ZStack {
            Image("Thanos") // Replace with your actual image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 400)
                .opacity(isDisintegrating ? 0 : 1)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 2)) {
                        isDisintegrating = true
                        generateParticles()
                    }
                }
            
            ForEach(0..<particles.count, id: \.self) { index in
                Circle()
                    .fill(Color.gray.opacity(0.8))
                    .frame(width: particles[index].1, height: particles[index].1)
                    .position(particles[index].0)
                    .opacity(isDisintegrating ? 0 : 1)
                    .animation(
                        .easeInOut(duration: 2)
                        .delay(Double.random(in: 0...1.5)),
                        value: isDisintegrating
                    )
            }
        }
        .frame(width: 300, height: 400)
    }
    
    func generateParticles() {
        particles = (0..<2100).map { _ in
            let randomX = CGFloat.random(in: 0...300)
            let randomY = CGFloat.random(in: 0...400)
            let size = CGFloat.random(in: 1...3)
            return (CGPoint(x: randomX, y: randomY), size)
        }
    }
}

#Preview {
    ThanosView()
}
