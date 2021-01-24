//
//  CardView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct CardView: View {
    var cardsData: Cards
    var body: some View {
        let colors = Gradient(colors: cardsData.wykorzystana ? [.purple,.blue]: [.gray])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        VStack {
            Image(uiImage: generateQRCode(from: cardsData.image))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .padding(.all, 30.0)
//                Color.white.cornerRadius(15)
//            AsyncImage(url: URL(string: cardsData.image)!,
//                           placeholder: { Text("Loading ...") },
//                           image: { Image(uiImage: $0).resizable()})
//            }.aspectRatio(contentMode: .fit).padding().cornerRadius(15)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(cardsData.data)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(cardsData.recepta)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(cardsData.lekarz.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(gradient, lineWidth: 10)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        var image = "QRCode"
        var data = "Data"
        var recepta = "Recepta"
        var lekarz = "Dr. Andrzej Wolny"
        CardView(cardsData: cardsData[0])
    }
}
