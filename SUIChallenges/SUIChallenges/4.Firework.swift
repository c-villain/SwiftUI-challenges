//
//  4.Firework.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 23.08.2022.
//

import SwiftUI

struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration =  Double.random(in: 3.0 ... 7.0)
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity((duration - time) / duration)
                    .animation(.easeOut(duration: duration).repeatForever(autoreverses: false), value: scale)
            }
        }
        .onAppear {
            time = duration
            scale = 1.0
        }
    }
}

struct Fireworks: View {
    
    @State var scaling: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Thanks so much!")
                        .font(.largeTitle)
                    Text("200")
                        .font(.system(size: 60))
                        .scaleEffect(scaling ? 1.1 : 1.0)
                        .animation(.easeOut(duration: 1.0).repeatForever(), value: scaling)
                    Text("I really appreciate you!")
                        .font(.largeTitle)
                }
                .padding()
                .vTop()
                
            }
            .zIndex(1)
            
            ForEach(0..<Int.random(in: 10...20), id: \.self) { _ in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .modifier(ParticlesModifier())
                    .offset(x: CGFloat.random(in: -200...200), y : CGFloat.random(in: -200...200))
            }
            .zIndex(2)
            
            Image("like-you")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .scaleEffect(scaling ? 1.2 : 1.0)
                .animation(.easeOut(duration: 1.0).repeatForever(), value: scaling)
                .vBottom()
                .zIndex(3)
        }
        .onAppear {
            scaling.toggle()
        }
    }
}

fileprivate extension View {
    
    // MARK: Vertical Center
    func vCenter() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .center)
    }
    
    // MARK: Vertical Top
    func vTop() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: Vertical Bottom
    func vBottom() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    // MARK: Horizontal Center
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // MARK: Horizontal Leading
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: Horizontal Trailing
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
