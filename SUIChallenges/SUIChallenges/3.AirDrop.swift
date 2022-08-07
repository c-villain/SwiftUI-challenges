//
//  3.AirDrop.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 07.08.2022.
//

import SwiftUI

@MainActor
final class AirDropViewModel: ObservableObject {
    enum State {
        case `init`
        case waiting
        case sending
        case sent
    }
    
    @Published var state: State = .`init`
    @Published var progress: Double = 0
    
    func dropFile() async {
        do {
            progress = 0
            state = .waiting
            try await Task.sleep(nanoseconds: 3_500_000_000) // to simulate waiting
            state = .sending
            for _ in 0...9 {
                let time = Double.random(in: 0.1...0.5) * 1_000_000_000
                try await Task.sleep(nanoseconds: UInt64.init(time)) // to simulate sending
                progress += 0.1
            }
            try await Task.sleep(nanoseconds: 1_500_000_000)
            state = .sent
        } catch { }
    }
}

struct AirDrop: View {
    
    @StateObject private var vm: AirDropViewModel = .init()
    
    @State private var isProgressVisible = true
    @State private var blinking: Bool = false
    @State private var showShimmer: Bool = false
    @State private var id = UUID()
    
    var restart: some View {
        Button {
            vm.state = .`init`
            vm.progress = 0
            isProgressVisible = true
            blinking = false
            showShimmer = false
            id = UUID()
        } label: {
            Text("Restart")
                .font(.largeTitle)
                .opacity(vm.state == .sent ? 1.0 : 0)
        }
    }
    
    var photoSkeleton: some View {
        Circle()
            .fill(Color(.systemGray))
            .overlay {
                Person()
                    .fill(Color(.systemGray6))
            }
            .frame(width: 190, height: 190)
    }
    
    var airDropButton: some View {
        VStack {
            ZStack {
                CircularProgressView(progress: vm.progress)
                    .frame(width: 210, height: 210)
                    .padding()
                    .opacity(isProgressVisible ? 1.0 : 0.0)
                    .animation(.linear, value: vm.progress)
                
                photoSkeleton
                    .opacity(0.8)
                
                photoSkeleton
                    .mask {
                        Capsule()
                            .fill(LinearGradient(gradient: .init(colors: [.clear, .white, .clear]), startPoint: .top, endPoint: .bottom))
                            .rotationEffect(.degrees(-120))
                            .offset(x: showShimmer ? 200 : -200)
                    }

            }
            .clipShape(Circle())
            .onTapGesture {
                Task {
                    await vm.dropFile()
                    withAnimation(.easeIn(duration: 0.7)) {
                        isProgressVisible.toggle()
                    }
                }
            }
            .disabled(vm.state == .sent)
            
            Text("iPhone")
                .foregroundColor(.gray)
                .font(.title2)
            
            switch vm.state {
            case .`init`:
                Text("from Alex")
                    .foregroundColor(.gray)
                    .font(.title2)
            case .waiting:
                Text("Waiting...")
                    .foregroundColor(Color(.systemGray3))
                    .font(.title2)
                    .opacity(blinking ? 0 : 1)
                    .animation(.easeIn(duration: 0.6).repeatForever(), value: blinking)
                    .onAppear {
                        withAnimation {
                            blinking = true
                        }
                    }
            case .sending:
                Text("Sending...")
                    .foregroundColor(Color(.systemGray3))
                    .font(.title2)
            case .sent:
                Text("Sent")
                    .foregroundColor(.blue)
                    .font(.title2)
                    .onAppear {
                        withAnimation(.linear.delay(1.5)) {
                            showShimmer.toggle()
                        }
                    }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            restart
            airDropButton
                .id(id)
        }
    }
    
}

struct CircularProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray3), lineWidth: 10)
                .zIndex(1)
            Circle()
                .trim(from: 0, to: CGFloat(self.progress))
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 10, lineCap: .square))
                .zIndex(2)
        }
        .rotationEffect(Angle(degrees: -90))
    }
}

struct Person: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            // head:
            path.addEllipse(in: .init(x: rect.midX - rect.maxX / (3.5 * 2), y: rect.maxY / 5 , width: rect.maxX / 3.5, height: rect.maxY / 3))
            
            // body:
            path.move(to: .init(x: rect.maxX / 5, y: rect.maxY * 4 / 5))

            path.addQuadCurve(to: CGPoint(x: rect.maxX * 4 / 5, y: rect.maxY * 4 / 5),
                              control: CGPoint(x: rect.midX, y: rect.midY))

            path.move(to: .init(x: rect.maxX * 4 / 5, y: rect.maxY * 4 / 5))

            path.addQuadCurve(to: CGPoint(x: rect.maxX / 5, y: rect.maxY * 4 / 5),
                              control: CGPoint(x: rect.midX, y: rect.maxY))

            path.closeSubpath()
        }
    }
    
}

struct AirDrop_Previews: PreviewProvider {
    static var previews: some View {
        AirDrop()
            .preferredColorScheme(.dark)
    }
}
