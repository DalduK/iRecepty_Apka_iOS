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
    var wykorzystana: String
    var body: some View {
        let colors = Gradient(colors: wykorzystana == "active" ? [.purple,.blue]: [.gray])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        VStack {
            if image == "NoImage"{
                VStack{
                    Text("Witaj wewnątrz aplikacji eRecepty!").font(.headline)
                Text("Tutaj będą wyświetlane twoje recepty, ").font(.headline)
                    Text("Pokaż je aptekarzowi!").font(.headline)
                    Text("Jeśli chcesz dowiedzieć więcej się").font(.headline).padding(.bottom,20)
                    Image(systemName: "shift.fill").resizable().frame(width: 20, height: 20)
                    Text("kliknij tutaj!").font(.headline).padding(.top, 20)
                }.padding(.vertical,100).multilineTextAlignment(.center)
            }else{
            Image(uiImage: generateQRCode(from: image))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .padding(.all, 30.0)
            }
            
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

