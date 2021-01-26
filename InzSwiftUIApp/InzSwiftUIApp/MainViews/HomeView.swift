//
//  HomeView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct HomeView: View {
    @State var index = 0
    @State var alpha: Double = 1
    @State var blurBack: Int = 30
    @State private var selection: Tab = .featured
    @State private var showUsed = false
    @State private var cards = [HomeData]()
    @EnvironmentObject var userAuth: UserAuth
    
    
    enum Tab {
        case featured
        case list
        case user
    }
    
    
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
    
    func cleanData(){
        cards.removeAll()
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView{
                GeometryReader { gx in
                    ScrollView(.vertical, showsIndicators: false) {
                        ZStack{
                            VStack {
                                HStack{
                                    Text("Witaj " + userAuth.getUserName())
                                        .font(.system(size:30, weight: .bold))
                                    Spacer()
                                    Button(action: {
                                        
                                    }, label: {
                                        
                                        Image(systemName: "repeat.circle.fill")
                                            .resizable()
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                    .padding(.trailing, 10.0)
                                    
                                    Menu {
                                        Button(action: {
                                            
                                        }) {
                                            Text("Nowe")
                                            Image(systemName: "arrow.up.bin")
                                        }
                                        
                                        Button(action: {
                                            
                                        }) {
                                            Text("Wykorzystane")
                                            Image(systemName: "xmark.bin")
                                        }
                                        
                                        Button(action: {
                                            
                                        }) {
                                            Text("Wszystkie")
                                            Image(systemName: "archivebox")
                                        }
                                    } label: {
                                        Image(systemName: "ellipsis.circle")
                                            .resizable()
                                            .frame(width: 25.0, height: 25.0)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 10)
                                ScrollView (.horizontal, showsIndicators: true){
                                    HStack(spacing: 20)
                                    {
                                        ForEach(cardsData) { cards in
                                            NavigationLink(destination: PrescriDetails(cardDetail: cards)){
                                                GeometryReader { geometry in
                                                    CardView(cardsData: cards)
                                                        .rotation3DEffect(.degrees(0), axis: (x: 40, y: 0, z: 0))
                                                }
                                                .padding()
                                                .frame(width: gx.size.width, height: gx.size.height * 0.8)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Powrót")
                .navigationBarHidden(true)
            }
            .tabItem {
                Label("Karty", systemImage: "greetingcard.fill")
            }.tag(Tab.featured)
            
            PrescriList()
                .tabItem {
                    Label("Lista", systemImage: "list.bullet")
                }.tag(Tab.list)
            
            UserView()
                .tabItem {
                    Label("Ustawienia", systemImage: "person.crop.circle")
                }.tag(Tab.user)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
