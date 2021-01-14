//
//  ReceptList.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct ReceptList: View {
    @State private var showUsed = false
    var filteredCards: [Cards] {
        cardsData.filter { cards in
            (showUsed || cards.wykorzystana)
        }
    }
    var body: some View {
        NavigationView{
            
            List{
                Toggle("pokaż wykorzystane", isOn: $showUsed)
                ForEach(filteredCards){cards in
                NavigationLink(destination: ReceptDetails(cardDetail: cards)){
                    ReceptRowView(
                        image: cards.image,
                        data: cards.data,
                        recepta: cards.recepta,
                        lekarz: cards.lekarz,
                        wykorzystana: cards.wykorzystana
                    )
                }
                }
            }.navigationTitle("Recepty")
        }
    }
}
        

struct ReceptList_Previews: PreviewProvider {
    static var previews: some View {
        ReceptList()
    }
}
