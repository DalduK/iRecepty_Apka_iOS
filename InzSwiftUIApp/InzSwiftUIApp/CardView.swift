//
//  CardView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct CardView: View {
    var image: String
    var data: String
    var recepta: String
    var lekarz: String
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(data)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(recepta)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(lekarz.uppercased())
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
        CardView(image: image, data: data, recepta: recepta, lekarz: lekarz)
    }
}
