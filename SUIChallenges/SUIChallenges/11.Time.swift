//
//  11.Time.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 08.11.2022.
//

import SwiftUI

struct Time: View {
    @State var seconds : Double = Date().second
    @State var minutes : Double = Date().minute
    @State var hours : Double = Date().hour
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    let bezelSize: CGFloat = 350
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.gray,lineWidth: 10)
                .background(Circle().foregroundColor(Color.clear))
                .frame(width: bezelSize, height: bezelSize)
                .zIndex(3)
            
            Circle()
                .mask(ClockHand()
                    .frame(width: 100, height: 10))
                .rotationEffect(Angle.degrees(360 * seconds / 60 - 90))
                .foregroundColor(.blue)
                .frame(width: 200, height: 200)
                .offset(x: -(bezelSize - 10) / 4)
                .zIndex(2)
            
            Circle()
                .mask(ClockHand()
                    .frame(width: 200, height: 20))
                .rotationEffect(Angle.degrees(360 * minutes / 60 - 90))
                .frame(width: 280, height: 280)
                .zIndex(1)
            
            Circle()
                .mask(ClockHand()
                    .frame(width: 150, height: 20))
                .rotationEffect(Angle.degrees(360 * hours / 12 - 90))
                .frame(width: 200, height: 200)
                .zIndex(1)
            
          }.onReceive(timer) { time in

              self.seconds = Date().second
              self.minutes = Date().minute
              self.hours = Date().hour
              
              if self.seconds == 60.0 {
                  withAnimation(.none) {
                      self.seconds = 0.01 }
              }
              withAnimation(Animation.linear(duration: 1.0)) {
                  self.seconds = round(self.seconds + 1)
              }
          }
    }
}

extension Date {
    var second: Double {
        return Double(Calendar.current.dateComponents([.second], from: self).second ?? 0)
    }
    
    var minute: Double {
        return Double(Calendar.current.dateComponents([.minute], from: self).minute ?? 0)
    }
    
    var hour: Double {
        return Double(Calendar.current.dateComponents([.hour], from: self).hour ?? 0)
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: 0, y: 0))
        path.addLine(to: .init(x: rect.maxX - rect.maxX*0.07, y: 0))
        path.addLine(to: .init(x: rect.maxX, y: rect.midY))
        path.addLine(to: .init(x: rect.maxX - rect.maxX*0.07, y: rect.maxY))
        path.addLine(to: .init(x: 0, y: rect.maxY))

        return path
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow()
            .frame(width: 100, height: 10)
    }
}

struct ClockHand: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX + rect.maxY * 0.3, y: rect.maxY * 0.3))
            p.addLine(to: CGPoint(x: rect.maxX - rect.maxX * 0.04, y: rect.maxY * 0.3))
            
            p.addLine(to: .init(x: rect.maxX, y: rect.midY))
            
            p.addLine(to: .init(x: rect.maxX - rect.maxX * 0.04, y: rect.maxY * 0.7))
            
            p.addLine(to: .init(x: rect.midX + rect.maxY * 0.3, y: rect.maxY * 0.7))
            
            p.addEllipse(in: CGRect(x: rect.midX - rect.maxY * 0.3 , y: rect.midY - rect.maxY * 0.3, width: rect.maxY * 0.6, height: rect.maxY * 0.6))
        }.strokedPath(StrokeStyle(lineWidth: CGFloat(rect.height * 0.2), lineCap: .round))
    }
}

struct ClockHand_Previews: PreviewProvider {
    static var previews: some View {
        ClockHand()
            .frame(width: 200, height: 20)
    }
}
