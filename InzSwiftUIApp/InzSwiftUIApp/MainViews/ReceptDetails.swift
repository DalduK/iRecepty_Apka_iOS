//
//  ReceptDetails.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct ReceptDetails: View {
    var cardDetail: Cards
    var body: some View {
        GeometryReader{ (proxy : GeometryProxy) in
        VStack {
                    Image("Gradient")
                        .resizable()
                        .frame(width: proxy.size.width, height:proxy.size.height/2.4 , alignment: .topLeading)
            ZStack{
                Color.white
                Image(uiImage: generateQRCode(from: cardDetail.image))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .padding(.all, 30.0)
//            AsyncImage(url: URL(string: cardDetail.image)!,
//                           placeholder: { Text("Loading ...") },
//                           image: { Image(uiImage: $0).resizable()})
            }.aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .shadow(radius: 7)
                        .padding(.top, -200.0)
                .padding()
                

                    VStack(alignment: .leading) {
                        Text(cardDetail.recepta)
                            .font(.title)
                            .foregroundColor(.primary)

                        HStack {
                            Text(cardDetail.lekarz)
                            Spacer()
                            Text(cardDetail.data)
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                        Divider()

                        Text("Dodatkowe informacje o recepcie")
                            .font(.title2)
                        Text("Mozemy tutaj je dodac.")
                    }
                    .padding()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Wróć do listy!", displayMode: .inline)
        }
    }
}

struct ReceptDetails_Previews: PreviewProvider {
    static var previews: some View {
        ReceptDetails(cardDetail: cardsData[0])
        
    }
}
