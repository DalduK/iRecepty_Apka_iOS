//
//  ReceptList.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct PrescriList: View {
    @State private var showUsed = false
    @State private var cards = [HomeData]()
    func getHomeData(filter: String) {
        guard let url = URL(string: "https://recepty.eu.ngrok.io/recepty?filter=" + filter) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([HomeData].self, from: data) {
                    DispatchQueue.main.async {
                        self.cards = response
                    }
                    return
                }
            }
        }.resume()
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
                            Image(systemName: "arrow.up.bin")
                        }
                        
                        Button(action: {
                            // enable geolocation
                        }) {
                            Text("Wykorzystane")
                            Image(systemName: "xmark.bin")
                        }
                        
                        Button(action: {
                            // enable geolocation
                        }) {
                            Text("Wszystkie")
                            Image(systemName: "archivebox")
                        }
                    } label: {
                        Text("Wybierz recepty")
                        Spacer()
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .accentColor(.gray)
                    }
                    
                    Button(action: {
                        
                    }, label: {HStack{
                        Text("Odśwież Dane")
                        Spacer()
                        Image(systemName: "repeat.circle.fill")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .accentColor(.gray)
                    }
                    })
                }
                Section{
                    ForEach(cardsData){cards in
                        NavigationLink(destination: PrescriDetails(cardDetail: cards)){
                            PrescriRowView(
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
            .padding(.horizontal, -5)
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Recepty")
        }
    }
}


struct PrescriList_Previews: PreviewProvider {
    static var previews: some View {
        PrescriList()
    }
}
