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
                Section{
                    Menu {
                        Button(action: {
                            // change country setting
                        }) {
                            Text("Nowe")
                            Image(systemName: "globe")
                        }

                        Button(action: {
                            // enable geolocation
                        }) {
                            Text("Wykorzystane")
                            Image(systemName: "location.circle")
                        }
                        
                        Button(action: {
                            // enable geolocation
                        }) {
                            Text("Wszystkie")
                            Image(systemName: "location.circle")
                        }
                    } label: {
                        Text("Wybierz recepty")
                        Spacer()
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .accentColor(.gray)
                    }
                }
                Section{
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
                }
            }
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Recepty")
        }
    }
}
        

struct ReceptList_Previews: PreviewProvider {
    static var previews: some View {
        ReceptList()
    }
}
