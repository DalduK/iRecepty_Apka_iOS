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
    @EnvironmentObject var userAuth: UserAuth
    @State private var request = "all"
    @State var didAppear = false
    @State var appearCount = 0
    
    func onLoad() {
        if didAppear == false {
            appearCount += 1
            getHomeData(filter: request)
        }
        didAppear = true
    }
    
    func getHomeData(filter: String) {
        guard let url = URL(string: "https://recepty.eu.ngrok.io/api/prescription/patient/" + filter) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + userAuth.getToken(), forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("request")
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
                            DispatchQueue.main.async{
                            getHomeData(filter: request)
                            }
                        }) {
                            Text("Nowe")
                            Image(systemName: "arrow.up.bin")
                        }
                        
                        Button(action: {
                            getHomeData(filter: request)
                        }) {
                            Text("Wykorzystane")
                            Image(systemName: "xmark.bin")
                        }
                        
                        Button(action: {
                            getHomeData(filter: request)
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
                        getHomeData(filter: request)
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
                    if cards.isEmpty == true {
                        Text("Tutaj będą widoczne wszystkie twoje recepty w formie wygodnej listy.")
                        PrescriRowView(
                            image: "NoImage",
                            data: "25.01.2020",
                            recepta: "Witaj w aplikacji !",
                            lekarz:  "Tutaj będzie nazwa lekarza",
                            wykorzystana: "new"
                        )
                    }else{
                    ForEach(cards, id: \.number){cardsIter in
                        NavigationLink(destination: PrescriDetails(cardID: cardsIter.number, userAuth: userAuth, doctor: cardsIter.doctor)){
                            PrescriRowView(
                                image: cardsIter.number,
                                data: cardsIter.creationDate,
                                recepta: cardsIter.description,
                                lekarz: cardsIter.doctor,
                                wykorzystana: cardsIter.status
                            )
                        }
                    }
                    }
                }
            }.onAppear(perform: {
                onLoad()
            })
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
