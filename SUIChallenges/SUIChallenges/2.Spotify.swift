//
//  2.Spotify.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 04.08.2022.
//

import SwiftUI

struct Spotify: View {
    
    @State private var color: Color = Color.green
    @State private var frequency: CGFloat = 0.5
    @State private var columns: Int = 3
    
    var body: some View {
        ZStack {
            VStack(spacing: 16.0) {
                ColorPicker("", selection: $color)
                
                HStack {
                    Text("Frequency: \(String(format: "%.1f", frequency))")
                        .font(.title3)
                    Stepper("", onIncrement: {
                        frequency += 0.1
                    }, onDecrement: {
                        if frequency > 0.2 {
                            frequency -= 0.1
                        }
                    })
                }
                
                HStack {
                    Text("Columns: \(columns)")
                        .font(.title3)
                    Stepper("", onIncrement: {
                        columns += 1
                    }, onDecrement: {
                        if columns > 2 {
                            columns -= 1
                        }
                    })
                }
            }
            .vTop()
            .hTrailing()
            .padding(20.0)
            .zIndex(1)
            
            HStack {
                ForEach(0...columns, id: \.self) { _ in
                    Bar(color: color, interval: frequency)
                }
            }
            .frame(width: 170, height: 170)
            
        }
    }
}

struct Bar: View {
    
    let color: Color
    let timer: Timer.TimerPublisher
    
    @State private var paddingTop: CGFloat = 1.0
    
    init(color: Color, interval: TimeInterval) {
        self.color = color
        timer = Timer.publish(every: interval, on: .main, in: .common)
    }
    
    var body: some View {
        Segment(color: color, paddingTop: paddingTop)
            .animation(.spring(), value: paddingTop)
            .onReceive(timer.autoconnect()) { _ in
                paddingTop = CGFloat.random(in: 0...1)
            }
    }
}

struct Segment: Animatable, View {

    let color: Color
    var paddingTop: CGFloat = 1.0

    public var animatableData: CGFloat {
        get { paddingTop }
        set { paddingTop = newValue }
    }
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 8.0)
                .fill(color)
                .padding(.top, geometry.size.height * paddingTop)
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

struct Spotify_Previews: PreviewProvider {
    static var previews: some View {
        Spotify()
            .preferredColorScheme(.dark)
    }
}

