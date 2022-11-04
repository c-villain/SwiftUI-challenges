//
//  10.FastFoodLogo.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 29.10.2022.
//

import SwiftUI

enum Constants {
    enum Circle {
        enum Radius {
            static let scaled: CGFloat = 500
            static let basic: CGFloat = 25
        }
        
        enum Offset {
            static let offseted: CGFloat = 70
            static let basic: CGFloat = 0
        }
    }
}

struct FastFoodLogo: View {
    
    @State var changeMode = false
    @State var scaled = true
    @State var circleOffseted = true
    @State var rotate = false
    @State var stripesVisible = false
    @State var stripesOffseted = true
    @State var textRectVisible = false
    @State var textVisible = false
    @State var textOffseted = true
    @State var isFinished = true
    
    var body: some View {
        ZStack {
            Color(red: 38/255, green: 74/255, blue: 49/255).zIndex(0)
            
            ZStack(alignment: .center) {
                ZStack(alignment: .top) {
                    Circle()
                        .fill(.clear)
                        .frame(width: 300)
                        .zIndex(1)
                    
                    Circle()
                        .fill(Color(red: 231/255, green: 65/255, blue: 15/255))
                        .aspectRatio(contentMode: changeMode ? .fit : .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: scaled ? Constants.Circle.Radius.scaled * 2 : Constants.Circle.Radius.basic * 2)
                        .offset(y: circleOffseted ? Constants.Circle.Offset.basic : Constants.Circle.Offset.offseted )
                        .zIndex(2)
                        .onTapGesture {
                            guard isFinished else { return }
                            isFinished = false
                            changeMode.toggle()
                            withAnimation(.linear(duration: 0.5)) {
                                scaled.toggle()
                            }
                            withAnimation(.linear(duration: 1.0).delay(0.5)) {
                                rotate.toggle()
                            }
                            withAnimation(.spring(response: 0.6,
                                                  dampingFraction: 0.4,
                                                  blendDuration: 0).delay(1.5)) {
                                circleOffseted.toggle()
                            }
                            withAnimation(.linear(duration: 0.2).delay(1.5)) {
                                
                                textRectVisible.toggle()
                            }
                            withAnimation(.linear(duration: 0.2).delay(1.7)) {
                                stripesVisible.toggle()
                            }
                            withAnimation(.spring(response: 0.35,
                                                  dampingFraction: 0.25,
                                                  blendDuration: 0).delay(1.8)) {
                                stripesOffseted.toggle()
                            }
                            withAnimation(.linear(duration: 0.2).delay(2.3)) {
                                textVisible.toggle()
                            }
                            withAnimation(.linear(duration: 0.4).delay(2.4)) {
                                textOffseted.toggle()
                            }
                        }
                }
                .rotationEffect(.degrees(rotate ? 270 : 0))
                
                HStack(spacing: 0) {
                    Rectangle()
                            .fill(Color(red: 238/255, green: 116/255, blue: 3/255))
                            .clipShape(Stripe())
                            .frame(width: 60, height: 120)
                            .rotationEffect(.degrees(-30))
                            .offset(x: stripesOffseted ? -12 : 0, y: -30)
                        
                        Rectangle()
                            .fill(Color(red: 238/255, green: 116/255, blue: 3/255))
                            .clipShape(Stripe())
                            .frame(width: 60, height: 120)
                            .rotationEffect(.degrees(-30))
                            .offset(x: stripesOffseted ? -72 : -12, y: -30)
                    }
                    .opacity(stripesVisible ? 1 : 0)
                 
                VStack(spacing: 0) {
                    Text("ВКУСНО — И ТОЧКА")
                        .kerning(0)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title3)
                        .offset(y: textOffseted ? 20 : 0)
                        .opacity(textVisible ? 1 : 0)
                        .onTapGesture {
                            isFinished = true
                            changeMode = false
                            scaled = true
                            circleOffseted = true
                            rotate = false
                            stripesVisible = false
                            stripesOffseted = true
                            textRectVisible = false
                            textVisible = false
                            textOffseted = true
                        }
                    
                    Rectangle()
                        .fill(Color(red: 38/255, green: 74/255, blue: 49/255))
                        .frame(height: 60)
                }
                .fixedSize()
                .offset(y: 100)
                .opacity(textRectVisible ? 1 : 0)
            }
            .zIndex(1)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FastFoodLogo_Previews: PreviewProvider {
    static var previews: some View {
        FastFoodLogo()
    }
}

struct Stripe: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.maxX, y: 0))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY - rect.width / 2))
        path.addQuadCurve(to: .init(x: rect.midX, y: rect.maxY), control: .init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: .init(x: rect.width/2, y: rect.width / 2))
        path.addQuadCurve(to: .init(x: rect.maxX, y: 0), control: .init(x: rect.midX, y: 0))
        return path
    }
}

struct Logo: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            
            Circle()
                .fill(Color(red: 231/255, green: 65/255, blue: 15/255))
                .frame(width: 50.0)
            
            Rectangle()
                .fill(Color(red: 238/255, green: 116/255, blue: 3/255))
                .clipShape(Stripe())
                .frame(width: 60, height: 120)
                .rotationEffect(.degrees(-30))
                .offset(x: -30.0, y: 5)
            
            Rectangle()
                .fill(Color(red: 238/255, green: 116/255, blue: 3/255))
                .clipShape(Stripe())
                .frame(width: 60, height: 120)
                .rotationEffect(.degrees(-30))
                .offset(x: -40.0, y: 5)
        }
    }
}
