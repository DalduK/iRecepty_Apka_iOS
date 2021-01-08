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
        VStack {
                    Image("Gradient")
                        .resizable()
                        .frame(height: 260)
                        .ignoresSafeArea()
                        .padding(.top, -110)

                    Image(cardDetail.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
    }
}

struct ReceptDetails_Previews: PreviewProvider {
    static var previews: some View {
        ReceptDetails(cardDetail: cardsData[0])
    }
}
