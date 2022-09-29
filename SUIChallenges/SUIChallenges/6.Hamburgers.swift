//
//  6.Hamburgers.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 27.09.2022.
//

import SwiftUI

struct Hamburgers: View {
    var body: some View {
        VStack(spacing: 100) {
            Hamburger()
            Hamburger2()
            Hamburger3()
            Hamburger4()
        }
    }
}

struct Hamburger: View {
     
    @State private var isRotating = false
    @State private var isHidden = false

    var body: some View {
        VStack(spacing: 14){
            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .opacity(isHidden ? 0 : 1)
            
            ZStack {
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(isRotating ? -45 : 0), anchor: .center)
                
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(isRotating ? 45 : 0), anchor: .center)
            }
            
            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .opacity(isHidden ? 0 : 1)
        }
        .onTapGesture {
            withAnimation(.interpolatingSpring(stiffness: 500, damping: 35)){
                isRotating.toggle()
                isHidden.toggle()
            }
        }
    }
}

struct Hamburger2: View {
    
    @State private var isOffset = false
    @State private var isFirstRotating = false
    @State private var isSecondRotating = false
    @State private var isHidden = false
    @State private var isOpened = false
    
    var body: some View {
        VStack(spacing: 14) {
            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .offset(x: 0, y: isOffset ? 22 : 0)
                .opacity(isHidden ? 0 : 1)
            
            ZStack {
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(isFirstRotating ? (isSecondRotating ? -135 : -90) : 0), anchor: .center)
                
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(isFirstRotating ? (isSecondRotating ? -45 : -90) : 0), anchor: .center)
            }

            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .offset(x: 0, y: isOffset ? -22 : 0)
                .opacity(isHidden ? 0 : 1)
        }
        .onTapGesture {
            if !isOpened {
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35)){
                    isOffset.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.15)){
                    isHidden.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.3)){
                    isFirstRotating.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.45)){
                    isSecondRotating.toggle()
                    isOpened.toggle()
                }
            } else {
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35)){
                    isSecondRotating.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.15)){
                    isFirstRotating.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.3)){
                    isHidden.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.45)){
                    isOffset.toggle()
                    isOpened.toggle()
                }
            }
        }
    }
}

struct Hamburger3: View {
    
    @State private var isOffset = false
    @State private var isFirstRotating = false
    @State private var isSecondRotating = false
    @State private var isHidden = false
    @State private var isOpened = false
    
    var body: some View {
        VStack(spacing: 14) {
            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .offset(x: 0, y: isOffset ? 22 : 0)
                .opacity(isHidden ? 0 : 1)
            
            ZStack {
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(isFirstRotating ? -90 : 0), anchor: .center)
                    .rotationEffect(.degrees(isSecondRotating ? -135 : 0), anchor: .center)
                
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(isFirstRotating ? -90 : 0), anchor: .center)
                    .rotationEffect(.degrees(isSecondRotating ? -45 : 0), anchor: .center)
            }

            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .offset(x: 0, y: isOffset ? -22 : 0)
                .opacity(isHidden ? 0 : 1)
        }
        .onTapGesture {
            if !isOpened {
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35)){
                    isOffset.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.15)){
                    isHidden.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.3)){
                    isFirstRotating.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.45)){
                    isSecondRotating.toggle()
                    isOpened.toggle()
                }
            } else {
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35)){
                    isSecondRotating.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.15)){
                    isFirstRotating.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.3)){
                    isHidden.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.45)){
                    isOffset.toggle()
                    isOpened.toggle()
                }
            }
        }
    }
}

struct Hamburger4: View {
    
    @State private var isOffset = false
    @State private var isHidden = false
    @State private var isOpened = false
    @State private var angle1: Double = 0.0
    @State private var angle2: Double = 0.0
    
    var body: some View {
        VStack(spacing: 14) {
            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .offset(x: 0, y: isOffset ? 22 : 0)
                .opacity(isHidden ? 0 : 1)
            
            ZStack {
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(angle1), anchor: .center)
                
                Rectangle()
                    .frame(width: 88, height: 8)
                    .cornerRadius(4)
                    .rotationEffect(.degrees(angle2), anchor: .center)
            }

            Rectangle()
                .frame(width: 88, height: 8)
                .cornerRadius(4)
                .offset(x: 0, y: isOffset ? -22 : 0)
                .opacity(isHidden ? 0 : 1)
        }
        .onTapGesture {
            if !isOpened {
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35)){
                    isOffset.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.15)){
                    isHidden.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.3)){
                    angle1 = angle1 - 90
                    angle2 = angle2 - 90
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.45)){
                    angle1 = angle1 - 45
                    angle2 = angle2 + 45
                    isOpened.toggle()
                }
            } else {
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35)){
                    angle1 = angle1 + 45
                    angle2 = angle2 - 45
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.15)){
                    angle1 = angle1 - 90
                    angle2 = angle2 - 90
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.3)){
                    isHidden.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 35).delay(0.45)){
                    isOffset.toggle()
                    isOpened.toggle()
                }
            }
        }
    }
}

struct Hamburgers_Previews: PreviewProvider {
    static var previews: some View {
        Hamburgers()
    }
}
