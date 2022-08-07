//
//  1.Lamp.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 22.07.2022.
//

import SwiftUI

struct Lamp: View {
    
    let text = "SWIFTUI IS JUST AMAZING!!! \nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc. \n\n Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit"
    
    static let initialOffset: CGSize = .init(width: 0, height: 70)
    @State private var lampOffset: CGSize = initialOffset
    @State private var lampColor: Color = Color.yellow
    
    @State private var lampOn: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading) {
                    Text(text)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .font(Font.system(size:20))
                }
                .hLeading()
                .padding(.top, 130)
                .padding(.horizontal)
            }.zIndex(1)
            
            ColorPicker("", selection: $lampColor)
                .vTop()
                .hTrailing()
                .padding(20.0)
                .opacity(lampOn ? 0 : 1)
                .zIndex(2)
            
            ZStack(alignment: .top) {

                Rope(lampOffset: lampOffset)
                    .stroke(Color(.lightGray),
                            lineWidth: 4)
                
                Rectangle()
                    .fill(lampOn ? lampColor : .clear)
                    .frame(width: 150, height: 150)
                    .offset(x: lampOffset.width, y: lampOffset.height)
                    .blur(radius: 90)
                
                Image(systemName: "lightbulb.fill")
                    .resizable()
                    .frame(width: 30, height: 50)
                    .foregroundColor(lampOn ? lampColor : Color(.lightGray) )
                    .rotationEffect(.degrees(180))
                    .offset(x: lampOffset.width, y: lampOffset.height)
                    .overlay {
                        Circle()
                            .fill(.black)
                            .frame(width: 13, height: 13)
                            .offset(x: lampOffset.width, y: lampOffset.height)
                            .blur(radius: 8)
                            .opacity(lampOn ? 0 : 1)
                    }
                    .gesture(
                        DragGesture().onChanged { value in
                            lampOffset = .init(width: value.translation.width, height: value.translation.height + 70)
                        } .onEnded({ value in
                            lampOffset = Lamp
                            .initialOffset
                        })
                    )
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.6)) {
                            lampOn.toggle()
                        }
                    }
            }
            .animation(.spring(response: 0.35,
                               dampingFraction: 0.35,
                               blendDuration: 0),
                       value: lampOffset == Lamp.initialOffset )
            .edgesIgnoringSafeArea(.top)
            .zIndex(3)
        }
    }
}

struct Rope: Shape {
    
    var lampOffset: CGSize
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: .init(x: lampOffset.width + rect.midX, y: lampOffset.height))
        }
    }

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(lampOffset.width, lampOffset.height) }
        set {
            lampOffset.width = newValue.first
            lampOffset.height = newValue.second
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

struct Lamp_Previews: PreviewProvider {
    static var previews: some View {
        Lamp()
            .preferredColorScheme(.dark)
    }
}
