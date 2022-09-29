//
//  5.FlexCards.swift
//  SUIChallenges
//
//  Created by Alexander Kraev on 25.09.2022.
//

import SwiftUI

struct Card: Identifiable, Hashable {
    var id: Int
    var imageName: String
    var place: String
    var description: String
}

let cards: [Card] = [.init(id: 1, imageName: "1", place: "Kurilsk", description: "Yetorup island"),
                     .init(id: 2, imageName: "2", place: "Shallow seabed", description: "Yetorup island"),
                     .init(id: 3, imageName: "3", place: "Tug Korund", description: "Yetorup island"),
                     .init(id: 4, imageName: "4", place: "Lighthouse", description: "The Aniva cape"),
                     .init(id: 5, imageName: "5", place: "Rocks", description: "Okhotsckoe sea"),
                     .init(id: 6, imageName: "6", place: "Volcanic beach", description: "Yetorup island")]

struct FlexCards: View {
    
    @State var isSelected = cards[1]
    @State var selectedSize: CGFloat = 0
    @State var size: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("Sakhalin island, Russia")
                    .fontWeight(.medium)
                    .font(.largeTitle)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 4.0) {
                        ForEach(cards) { card in
                            CardView(image: card.imageName,
                                     place: card.place,
                                     description: card.description,
                                     buttonImage: isSelected == card ? "sun.min.fill" : "sun.min",
                                     size: .init(width: isSelected == card ? selectedSize : size, height: 220), isSelected: isSelected == card) {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    isSelected = card
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    let basicSize: CGFloat = geometry.size.width - 16.0 - (CGFloat)(8 * (cards.count - 1))
                    selectedSize = basicSize / 2
                    size = (basicSize * 0.5) / (CGFloat)(cards.count - 1)
                    print("selectedSize: \(selectedSize) size: \(size)")
                }
            }
        }
        .padding(8)
    }
}

struct FlexCards_Previews: PreviewProvider {
    static var previews: some View {
        FlexCards()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct CardView: View {
    
    let image: String
    let place: String
    let description: String
    let buttonImage: String
    
    let size: CGSize
    let isSelected: Bool
    var onTap: (() -> ())?
    
    var body: some View {
        Image("\(image)")
            .resizable()
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .cornerRadius(8)
            .clipped()
            .contentShape(Rectangle())
            .overlay(alignment: .bottomLeading) {
                HStack(spacing: 8.0) {
                    Image(systemName: buttonImage)
                        .foregroundColor(.white)
                        .frame(width: 24.0, height: 24.0)
                    if isSelected {
                        VStack(alignment: .leading) {
                            Text(place)
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            Text(description)
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                        .fixedSize()
                    }
                }
                .frame(height: 40)
                .padding(4.0)
            }
            .onTapGesture {
                onTap?()
            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "1",
                 place: "Kurilsk",
                 description: "Yetorup island",
                 buttonImage: "sun.min.fill",
                 size: .init(width: 159.0, height: 220.0),
                 isSelected: true)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
