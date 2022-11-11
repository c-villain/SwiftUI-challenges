//
//  11.Time.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 08.11.2022.
//

import SwiftUI

// MARK: - Constants
fileprivate enum Constants {
    enum sizes {
        static let bezelSize: CGFloat = 350
        static let dial: CGFloat = 300
        static let secondsDial: CGFloat = 70
    }
    
    enum colors {
        static let luminofor = Color(red: 170/255, green: 185/255, blue: 156/255)
        static let bg = Color(red: 64/255, green: 64/255, blue: 64/255)
        static let dateBg = Color(red: 49/255, green: 49/255, blue: 49/255)
        static let text = Color(red: 221/255, green: 202/255, blue: 181/255)
    }
}

// MARK: - Panerai view
struct Time: View {
    @State var seconds : Double = Date().second
    @State var minutes : Double = Date().minute
    @State var hours : Double = Date().hour
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
       
        ZStack {
            Circle()
                .strokeBorder(Color.gray,lineWidth: 10)
                .background(Circle().foregroundColor(Constants.colors.bg))
                .frame(width: Constants.sizes.bezelSize, height: Constants.sizes.bezelSize)
                .opacity(0.8)
                .zIndex(0)
            
            ForEach(0..<12) { hour in
                if (hour % 3 != 0) {
                    Hour()
                        .stroke(lineWidth: 8)
                        .fill(Constants.colors.luminofor)
                        .rotationEffect(.radians(Double.pi * 2 / 12 * Double(hour)))
                } else if hour == 9 {
                    Hour(length: 17)
                        .stroke(lineWidth: 8)
                        .fill(Constants.colors.luminofor)
                        .rotationEffect(.radians(Double.pi * 2 / 12 * Double(hour)))
                }
            }
            .frame(width: Constants.sizes.dial, height: Constants.sizes.dial)
            
            Group {
                Text("12")
                    .kerning(0.5)
                    .foregroundColor(Constants.colors.luminofor)
                    .fontWeight(.bold)
                    .font(.system(size: 54, weight: .heavy, design: .rounded))
                    .offset(y: -Constants.sizes.dial/2 + 15)
                
                Text("6")
                    .kerning(0.5)
                    .foregroundColor(Constants.colors.luminofor)
                    .fontWeight(.bold)
                    .font(.system(size: 54, weight: .heavy, design: .rounded))
                    .offset(y: Constants.sizes.dial/2 - 15)
                    
                ZStack {
                    Constants.colors.dateBg
                    
                    Text("\(Date().get(.day))")
                        .kerning(0.5)
                        .foregroundColor(Constants.colors.text)
                        .fontWeight(.bold)
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                }
                .frame(width: 30, height: 20)
                .offset(x: Constants.sizes.dial/2 - 15)
            }
            .zIndex(1)
            
            ZStack {
                ForEach(0..<12) { hour in
                    Hour(length: hour % 3 == 0 ? 8 : 4)
                        .stroke(lineWidth: hour % 3 == 0 ? 3 : 2)
                        .fill(hour % 3 == 0 ? Constants.colors.luminofor : Constants.colors.text)
                        .rotationEffect(.radians(Double.pi * 2 / 12 * Double(hour)))
                }
                
                Circle()
                    .mask(ClockHand()
                        .frame(width: Constants.sizes.secondsDial, height: 10))
                    .rotationEffect(Angle.degrees(360 * seconds / 60 - 90))
                    .foregroundColor(.blue)
            }
            .frame(width: Constants.sizes.secondsDial, height: Constants.sizes.secondsDial)
            .offset(x: -(Constants.sizes.bezelSize - 10) / 4)
            .zIndex(2)
            
            Circle()
                .mask(ClockHand()
                    .frame(width: 280, height: 20))
                .rotationEffect(Angle.degrees(360 * minutes / 60 - 90))
                .frame(width: 300, height: 300)
                .zIndex(3)
            
            Circle()
                .mask(ClockHand()
                    .frame(width: 200, height: 20))
                .rotationEffect(Angle.degrees(360 * hours / 12 - 90))
                .frame(width: 300, height: 300)
                .zIndex(4)
            
            Text("PANERAI")
                .kerning(0.5)
                .foregroundColor(Constants.colors.text)
                .fontWeight(.bold)
                .font(.title3)
                .offset(y: (Constants.sizes.dial - 10) / 4)
                .zIndex(1)
            
            VStack(spacing: 0) {
                Text("LUMINOR")
                    .kerning(0.5)
                    .foregroundColor(Constants.colors.text)
                    .fontWeight(.bold)
                    .font(.title3)
                Text("MARINA")
                    .kerning(0.5)
                    .foregroundColor(Constants.colors.text)
                    .fontWeight(.bold)
                    .font(.title3)
            }
            .fixedSize()
            .offset(y: -(Constants.sizes.dial - 10) / 4)
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

// MARK: - Date extension
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
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

// MARK: - Shapes
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

struct Hour: Shape {
    
    var length: Double = 30
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX , y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.minY + length))
        }
        .strokedPath(.init(lineCap: .round))
        
    }
}

// MARK: - Previews
struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow()
            .frame(width: 100, height: 10)
    }
}

struct ClockHand_Previews: PreviewProvider {
    static var previews: some View {
        ClockHand()
            .frame(width: 200, height: 20)
    }
}

struct Hour_Previews: PreviewProvider {
    static var previews: some View {
        Hour()
            .frame(width: 100, height: 20)
    }
}

struct Time_Previews: PreviewProvider {
    static var previews: some View {
        Time()
    }
}
