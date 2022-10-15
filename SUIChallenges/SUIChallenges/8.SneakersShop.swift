//
//  8.SneakersShop.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 15.10.2022.
//

import SwiftUI

struct Hoka: Identifiable {
    let id: Int
    let image: String
    let name: String
    let sizes: [String]
    let colors: [Color]
}

struct SneakersShop: View {

    @State var sneakers: [Hoka] = [.init(id: 1, image: "hoka_1", name: "Hoka Clifton 3", sizes: ["41", "42", "42.5", "43", "44"], colors: [.black, .yellow, .white]),
                                   .init(id: 2, image: "hoka_2", name: "Hoka Rincon", sizes: ["40", "42.5"], colors: [.black, .red]),
                                   .init(id: 3, image: "hoka_3", name: "Hoka Clifton 4", sizes: ["41", "42", "42.5", "43"], colors: [.yellow, .black, .blue])]
    @State var selectedId: Int = 0
    @State var searchText: String = ""
    @State var inCartCount: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.gray.opacity(0.3)
                    .ignoresSafeArea(.all, edges: .all)
                
                Cloud(alignment: .topTrailing, proxy: proxy, offset: .init(width: 230, height: -100), frameHeightRatio: 1.6, color: .red)
                    .opacity(0.8)
                
                Cloud(alignment: .bottomLeading, proxy: proxy, offset: .init(width: -230, height: 120), frameHeightRatio: 1.4, color: .blue)
                    .opacity(0.7)
                
                ScrollView {
                    VStack {
                        
                        HStack {
                            Text("Welcome 🤙🏻")
                                .font(.largeTitle)
                         
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                
                                ZStack {
                                    Image(systemName: "cart.fill")
                                        .resizable()
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(
                                            .black.opacity(0.7)
                                        )
                                        .cornerRadius(8.0)
                                    Text("\(inCartCount > 99 ? "99+" : "\(inCartCount)")")
                                        .kerning(0.3)
                                        .lineLimit(1)
                                        .font(.subheadline)
                                        .truncationMode(.tail)
                                        .foregroundColor(.yellow.opacity(0.9))
                                        .padding(.horizontal, 4)
                                        .cornerRadius(50)
                                        .opacity(inCartCount == 0 ? 0.0 : 1.0)
                                        .offset(x: 16.0, y: -8.0)
                                }
                            }.frame(width: 50)
                        }
                        
                        HStack {
                            SearchBar(text: $searchText) {
                                withAnimation(.linear) {
                                    selectedId = 0
                                }
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "slider.horizontal.3")
                                    .resizable()
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(
                                        .black.opacity(0.7)
                                    )
                                    .cornerRadius(8.0)
                                
                            }.frame(width: 50)
                        }
                        .frame(height: 50)
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "square.grid.2x2.fill")
                                    .padding()
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                            }
                            .frame(width: 30, height: 30)
                            
                            Text("MOST POPULAR")
                                .font(.caption)
                                .fontWeight(.heavy)
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Show all")
                                    .foregroundColor(.white)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .opacity(0.7)
                            }
                        }
                        .offset(y: 30)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(sneakers, id: \.id) { sneaker in
                                    Sneaker(isSelected: sneaker.id == selectedId,
                                            imageName: sneaker.image,
                                            name: sneaker.name,
                                            availableSizes: sneaker.sizes,
                                            colors: sneaker.colors) {
                                        inCartCount = inCartCount + 1
                                    }
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            selectedId = sneaker.id
                                        }
                                    }
                                    .frame(height: 350.0)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        .onTapGesture {
            withAnimation(.linear) {
                selectedId = 0
            }
        }
    }
}

struct Cloud: View {
    
    let alignment: Alignment
    let proxy: GeometryProxy
    let offset: CGSize
    let frameHeightRatio: CGFloat
    let color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height /  frameHeightRatio)
            .offset(offset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

struct Sneaker: View {
    
    let isSelected: Bool
    let imageName: String
    let name: String
    let availableSizes: [String]
    let colors: [Color]
    let action: (() -> ())?
    
    private let imageSize: CGSize = .init(width: 150, height: 70.0)
    
    var body: some View {
        VStack {
            VStack(spacing: 10.0) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: isSelected ? imageSize.width * 2.5: imageSize.width,
                           height: isSelected ? imageSize.height * 2.5 : imageSize.height)
                    .offset(x: isSelected ? 30 : 0.0, y: isSelected ? -60.0 : 0.0)
                    .rotationEffect(isSelected ? .degrees(-30.0) : .degrees(0.0))
                Text(name)
                    .fontWeight(.heavy)
                    .offset(y: isSelected ? -60.0 : 0.0)
            }

            if isSelected {
                Group {
                    HStack {
                        Text("SIZE:")
                            .fontWeight(.medium)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(availableSizes, id: \.self) {
                                    Text($0)
                                        .foregroundColor(.black)
                                        .background(
                                            RoundedRectangle(cornerRadius: 4)
                                                .fill(.white)
                                        )
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("COLOR:")
                            .fontWeight(.medium)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(colors, id: \.self) {
                                    Circle()
                                        .stroke(.black, lineWidth: 2)
                                        .background(Circle().fill($0))
                                        .frame(width: 20, height: 22)
                                }
                            }
                            .padding(.horizontal, 8.0)
                        }
                    }
                    .frame(height: 20.0)
                    
                    Button {
                        action?()
                    } label: {
                        Capsule()
                            .fill(.white)
                            .overlay(
                                Text("BUY NOW")
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                            )
                            .frame(height: 30)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .offset(y: isSelected ? -50.0 : 0.0)
                .opacity(isSelected ? 1.0 : 0.0)
            }
        }
        .padding(8.0)
        .frame(width: 170.0, height: 250.0)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 8, style: .continuous)
        )
    }
}

struct SneakersShop_Previews: PreviewProvider {
    static var previews: some View {
        SneakersShop()
    }
}

struct Sneaker_Previews: PreviewProvider {
    static var previews: some View {
        Sneaker(isSelected: true,
                imageName: "hoka_1",
                name: "Hoka Clifton",
                availableSizes: ["41", "42", "42.5", "43"], colors: [.blue, .red, .green]) { }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @State var placeholder: String = "Search for the sneakers"
    let action: (() -> ())?
    
    var body: some View {
        Group{
            HStack {
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .frame(width: 20.0, height: 20.0)
                    .foregroundColor(.black)
                    .padding(.leading, 16)
                    .padding(.trailing, 11)
                    .opacity(0.3)
                
                Rectangle()
                    .frame(width: 2.0)
                    .padding(.horizontal, 3.0)
                    .padding(.vertical, 8.0)
                    .opacity(0.3)
                
                TextField(placeholder, text: $text)
                .onTapGesture {
                    action?()
                }
            }
            .buttonStyle(PlainButtonStyle())
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
        }
        .cornerRadius(8)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("")) {}
    }
}

private struct ScaleButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.05 : 0)
    }
}

private extension ButtonStyle where Self == ScaleButtonStyle {
    static var scale: ScaleButtonStyle {
        ScaleButtonStyle()
    }
}
