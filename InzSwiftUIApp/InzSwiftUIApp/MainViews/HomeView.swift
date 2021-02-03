//
//  HomeView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI
import Foundation


struct HomeView: View {
    @State var index = 0
    @State var alpha: Double = 1
    @State var blurBack: Int = 30
    @State private var selection: Tab = .featured
    @State private var showUsed = false
    @State private var cards = [HomeData]()
    @EnvironmentObject var userAuth: UserAuth
    @State private var request = "active"
    @State var didAppear = false
    @State var appearCount = 0
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
  
        
    enum Tab {
        case featured
        case list
        case user
    }
    func onLoad() {
        if didAppear == false {
            appearCount += 1
            getHomeData(filter: request)
        }
        didAppear = true
    }
    
    var typeOfPresc:  String {
        if request == "all"{
            return "Wszystkie"
        } else if request == "retired" {
            return "Wykorzystane"
        }else {
            return "Aktywne"
        }
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
            var statusCode: Int = 0
            guard let data = data, let response = response, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            print("StatusCode: \(statusCode)")
            if statusCode == 200{
                errorAction = false
                if let dataJSON = try? JSONDecoder().decode([HomeData].self, from: data){
                    DispatchQueue.main.async {
                        self.cards = dataJSON
                        cards.sort {
                            $0.creationDate < $1.creationDate
                        }
                    }
                    return
                }
            }else {
                loadingAction = false
                errorname = "Użytkownik Wylogowany"
                errordetails = "Ktoś zalogował się na innym urządzeniu, bądź token utracił ważność. Zaloguj się ponownie"
                errorAction = true
            }
            
        }
        .resume()
    }
    
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView{
                GeometryReader { gx in
                    ScrollView(.vertical, showsIndicators: false) {
                        ZStack{
                            VStack {
                                HStack{
                                    Text("Witaj " + userAuth.getUserName()).lineLimit(1)
                                        .font(.system(size:30, weight: .bold))
                                    Spacer()
                                    Button(action: {
                                        getHomeData(filter: request)
                                    }, label: {
                                        
                                        Image(systemName: "repeat.circle.fill")
                                            .resizable()
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                    .padding(.trailing, 10.0)
                                    
                                    Menu {
                                        Button(action: {
                                            request = "active"
                                            getHomeData(filter: request)
                                        }) {
                                            Text("Aktywne")
                                            Image(systemName: "arrow.up.bin")
                                        }
                                        
                                        Button(action: {
                                            request = "retired"
                                            getHomeData(filter: request)
                                        }) {
                                            Text("Wykorzystane")
                                            Image(systemName: "xmark.bin")
                                        }
                                        
                                        Button(action: {
                                            request = "all"
                                            getHomeData(filter: request)
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
                                HStack{
                                    Text("Wyświetlane recepty")
                                    Spacer()
                                    Text(typeOfPresc)
                                }.padding(.horizontal, 20).padding(.bottom,10)
                                if cards.isEmpty == true {
                                    NavigationLink(destination: FristTimeView()){
                                    CardView(image: "NoImage", data: "25.01.2020", recepta: "Witaj w aplikacji !", lekarz: "Tutaj będzie nazwa lekarza", wykorzystana: "new").padding()
                                        .frame(width: gx.size.width, height: gx.size.height * 0.8)
                                    }
                                }else{
                                    
            
                                    ScrollView (.horizontal, showsIndicators: true){
                                        HStack(spacing: 20)
                                        {
                                            ForEach(cards,id: \.number) { cardsIter in
                                                let doubleTime = Double(cardsIter.creationDate)
                                                let date = getDateFromTimeStamp(timeStamp: doubleTime!)
                                                NavigationLink(destination: PrescriDetails(cardID: cardsIter.number, userAuth: userAuth, doctor: cardsIter.doctor)){
                                                    GeometryReader { geometry in
                                                        CardView(image: cardsIter.number,
                                                                 data: date,
                                                                 recepta: cardsIter.description,
                                                                 lekarz: cardsIter.doctor,
                                                                 wykorzystana: cardsIter.status)
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
                }
                .onAppear(perform: {
                    onLoad()
                })
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
        .alert(isPresented: $errorAction){
            Alert(title: Text(errorname),
                message: Text(errordetails),
                dismissButton: Alert.Button.default(
                    Text("Zamknij"), action: { userAuth.logout() }
                )
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
