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
    @EnvironmentObject var userAuth: UserAuth

        enum Tab {
            case featured
            case list
            case user
        }
    var filteredCards: [Cards] {
        cardsData.filter { cards in
            (showUsed || cards.wykorzystana)
        }
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView{
                GeometryReader { gx in
                    ScrollView(.vertical, showsIndicators: false) {
                        ZStack{
                            VStack {
                                HStack{
                                    Text("Witaj " + userAuth.userName)
                                        .font(.system(size:30, weight: .bold))
                                    Spacer()
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
                                        ForEach(filteredCards) { cards in
                                                NavigationLink(destination: ReceptDetails(cardDetail: cards)){
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
            
            ReceptList()
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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        @Biding var showMenu = true
//        HomeView(showMenu: $showMenu)
//    }
//}
