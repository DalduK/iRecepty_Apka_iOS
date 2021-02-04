//
//  ReceptRowView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct PrescriRowView: View {
    var image: String
    var data: String
    var recepta: String
    var lekarz: String
    var wykorzystana:String
    var body: some View {
        HStack {
            ZStack{
                Color.white
                Image(uiImage: generateQRCode(from: image))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
            }.frame(width: 70.0, height: 70.0)
            .cornerRadius(2)
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

struct PrescriRowView_Previews: PreviewProvider {
    static var previews: some View {
        let image = "QRCode"
        let data = "Data"
        let recepta = "Recepta"
        let lekarz = "Dr. Andrzej Wolny"
        PrescriRowView(image: image, data: data, recepta: recepta, lekarz: lekarz, wykorzystana: "new")
    }
}
