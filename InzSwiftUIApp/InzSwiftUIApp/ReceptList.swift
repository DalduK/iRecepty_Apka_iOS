//
//  ReceptList.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct ReceptList: View {
    var body: some View {
        NavigationView{
            List(cardsData){ cards in
                NavigationLink(destination: ReceptDetails(cardDetail: cards)){
                    ReceptRowView(
                        image: cards.image,
                        data: cards.data,
                        recepta: cards.recepta,
                        lekarz: cards.lekarz
                    )
                } 
            }.navigationTitle("Recepty")
        }.accentColor( .white)
    }
}
        

struct ReceptList_Previews: PreviewProvider {
    static var previews: some View {
        ReceptList()
    }
}
