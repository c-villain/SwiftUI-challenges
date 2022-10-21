//
//  9.DynamicIsland.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 20.10.2022.
//

import SwiftUI
import Combine

struct DynamicIsland: View {
    
    @State var showIncomingCall = false
    @State var showNewPost = false
    @State var showOngoingCall = false
    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .top) {
                if UIApplication.shared.withDynamicIsland {
                    IncomingCallView(size: reader.size,
                                     isShown: $showIncomingCall)
                    
                    SwiftUIDevPost(size: reader.size,
                                   isShown: $showNewPost)
                    
                    OngoingCallView(size: reader.size,
                                    isShown: $showOngoingCall)
                    
                    VStack(spacing: 24) {
                        Button {
                            withAnimation(.linear(duration: 0.3)) {
                                showIncomingCall.toggle()
                            }
                        } label: {
                            Text(showIncomingCall ? "Dismiss" : "Incoming call")
                        }.opacity(showNewPost || showOngoingCall ? 0 : 1)
                        
                        Button {
                            withAnimation(.linear(duration: 0.3)) {
                                showNewPost.toggle()
                            }
                        } label: {
                            Text(showNewPost ? "Dismiss" : "@SwiftUI_Dev: new post")
                        }.opacity(showIncomingCall || showOngoingCall ? 0 : 1)
                        
                        Button {
                            withAnimation(.linear(duration: 0.3)) {
                                showOngoingCall.toggle()
                            }
                        } label: {
                            Text(showOngoingCall ? "Dismiss" : "Ongoing phone call")
                        }.opacity(showIncomingCall || showNewPost ? 0 : 1)
                        
                        Text("@LexKraev")
                            .fontWeight(.regular)
                            .opacity(showIncomingCall || showNewPost || showOngoingCall ? 0 : 0.5)
                    }
                    .position(x: reader.frame(in: .local).midX, y: reader.frame(in: .local).midY)
                } else {
                    Text("Please launch app on the iPhone 14 Pro or Pro Max")
                        .padding()
                        .position(x: reader.frame(in: .local).midX, y: reader.frame(in: .local).midY)
                }
            }
        }
        .ignoresSafeArea()
        .statusBarHidden(showIncomingCall || showNewPost || showOngoingCall)
    }
}

struct IncomingCallView: View {
    var size: CGSize
    @Binding var isShown: Bool
    
    var body: some View {
        HStack {
            Group {
                Image("me")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("iPhone")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Text("Alexander Kraev")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    withAnimation(.linear(duration: 0.3)) {
                        isShown.toggle()
                    }
                } label: {
                    Image(systemName: "phone.down.fill")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 14, height: 14)
                      .foregroundColor(.white)
                      .padding(14)
                      .background(.red)
                      .clipShape(Circle())
                }
                
                Button {
                
                } label: {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.white)
                        .padding(14)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            .opacity(isShown ? 1.0 : 0.0)
        }
        .padding()
        .frame(width: isShown ? size.width - 22 : 126, height: isShown ? 80 : 37.33)
        .background(
            RoundedRectangle(cornerRadius: isShown ? 50 : 63, style: .continuous)
                .fill(.black)
        )
        .offset(y: 11)
    }
}

struct SwiftUIDevPost: View {
    var size: CGSize
    @Binding var isShown: Bool
    @State private var isSubscribed = false
    
    var body: some View {
        HStack {
            Group {
                Image("SwiftLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("SwiftUI dev")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    
                    Text("New post: Dynamic island")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        isSubscribed.toggle()
                    }
                } label: {
                    Image(systemName: isSubscribed ? "bell.fill" : "bell")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 14, height: 14)
                      .foregroundColor(.white)
                      .padding(14)
                      .background(.red.opacity(0.8))
                      .clipShape(Circle())
                }
                
                Button {
                    withAnimation(.linear(duration: 0.3)) {
                        isShown.toggle()
                    }
                } label: {
                    Image(systemName: "hand.thumbsup.fill")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 14, height: 14)
                      .foregroundColor(.white)
                      .padding(14)
                      .background(.cyan)
                      .clipShape(Circle())
                }
            }
            .opacity(isShown ? 1.0 : 0.0)
        }
        .padding()
        .frame(width: isShown ? size.width - 22 : 126, height: isShown ? 80 : 37.33)
        .background(
            RoundedRectangle(cornerRadius: isShown ? 50 : 63, style: .continuous)
                .fill(.black)
        )
        .offset(y: 11)
    }
}

struct OngoingCallView: View {
    var size: CGSize
    @Binding var isShown: Bool
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    @State var timer: Timer? = nil
    
    var body: some View {
        HStack {
            Group {
                HStack (spacing: 8) {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.green)
                    
                    Text("\(minutes):" + (seconds < 10 ? "0" + String(seconds): "\(seconds)"))
                        .foregroundColor(.green)
                }
                Spacer()
                
                // Voice bar
                HStack(spacing: 1.0) {
                    ForEach(0...15, id: \.self) { _ in
                        Bar(color: .white, interval: 0.1)
                    }
                }
                .frame(width: 60, height: 20)
            }
            .opacity(isShown ? 1.0 : 0.0)
        }
        .padding()
        .frame(width: isShown ? 280 : 126, height: 37.33)
        .background(
            RoundedRectangle(cornerRadius: isShown ? 50 : 63, style: .continuous)
                .fill(.black)
        )
        .offset(y: 11)
        .onChange(of: isShown) { value in
            value ? startTimer() : stopTimer()
            print("value: \(value)")
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            if seconds == 59 {
                seconds = 0
                if minutes == 59 {
                    minutes = 0
                    hours = hours + 1
                } else {
                    minutes = minutes + 1
                }
            } else {
                seconds = seconds + 1
            }
        }
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
        hours = 0
        minutes = 0
        seconds = 0
    }
}

fileprivate struct Bar: View {
    
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
                paddingTop = CGFloat.random(in: 0...0.4)
            }
    }
}

fileprivate struct Segment: Animatable, View {

    let color: Color
    var paddingTop: CGFloat = 1.0

    public var animatableData: CGFloat {
        get { paddingTop }
        set { paddingTop = newValue }
    }
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 12.0)
                .fill(color)
                .frame(width: 3)
                .padding(.vertical, geometry.size.height * paddingTop)
        }
    }
}

fileprivate extension UIApplication {
    var withDynamicIsland: Bool {
        return UIDevice.current.name == "iPhone 14 Pro" || UIDevice.current.name == "iPhone 14 Pro Max"
    }
}
