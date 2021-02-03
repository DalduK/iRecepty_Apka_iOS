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
    @State private var request = "active"
    @State var didAppear = false
    @State var appearCount = 0
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
    
    
    
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
        NavigationView{
            
            List{
                Section{
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
                    }  label: {
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
                    
                    HStack{
                        Text("Wyświetlane recepty")
                        Spacer()
                        Text(typeOfPresc)
                    }
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
                        let doubleTime = Double(cardsIter.creationDate)
                        let date = getDateFromTimeStamp(timeStamp: doubleTime!)
                        NavigationLink(destination: PrescriDetails(cardID: cardsIter.number, userAuth: userAuth, doctor: cardsIter.doctor)){
                            PrescriRowView(
                                image: cardsIter.number,
                                data: date,
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
}


struct PrescriList_Previews: PreviewProvider {
    static var previews: some View {
        PrescriList()
    }
}
