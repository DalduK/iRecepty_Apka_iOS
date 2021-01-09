//
//  ReceptRowView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct ReceptRowView: View {
    var image: String
    var data: String
    var recepta: String
    var lekarz: String
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 70, height: 70)
            VStack{
                HStack {
                Text(data)
                    .font(.subheadline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                Spacer()
                }
                    
                HStack {
                Text(recepta)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Spacer()
                }
                HStack {
                Text(lekarz.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                }
               
            }
            Spacer()
        }
    }
}

struct ReceptRowView_Previews: PreviewProvider {
    static var previews: some View {
        var image = "QRCode"
        var data = "Data"
        var recepta = "Recepta"
        var lekarz = "Dr. Andrzej Wolny"
        ReceptRowView(image: image, data: data, recepta: recepta, lekarz: lekarz)
    }
}
