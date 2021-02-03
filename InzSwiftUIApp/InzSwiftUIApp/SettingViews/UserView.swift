//
//  UserView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct UserView: View {
//    @AppStorage("Mode") private var isDarkMode = 0
    @EnvironmentObject var userAuth: UserAuth
    @State var userData = [UserModel]()
    @State var didAppear = false
    @State var appearCount = 0
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
    
    func onLoad() {
        if didAppear == false {
            appearCount += 1
            getUserData()
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
                if let dataJSON = try? JSONDecoder().decode(UserModel.self, from: data){
                    DispatchQueue.main.async {
                        self.userData.append(dataJSON)
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
    
    func getUserData() {
        guard let url = URL(string: "https://recepty.eu.ngrok.io/api/user/details") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + userAuth.getToken(), forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print("data")
                let str = String(decoding: data, as: UTF8.self)
                print(str)
                print("request")
                if let response = try? JSONDecoder().decode(UserModel.self, from: data) {
                    DispatchQueue.main.async {
                        self.userData.append(response)
                        print(userData[0])
                    }
                    return
                }
            }
        }.resume()
    }
    
    var body: some View {
        NavigationView{
            List{
                Section {
                    Text("Dane użytkownika")
                        .font(.headline)
                        .fontWeight(.bold)
                        
                }
                
                if userData.isEmpty == false{
                    Section {
                        HStack{
                            Text("Nazwa użytkownika")
                                .foregroundColor(Color.gray)
                            Spacer()
                        Text(userData[0].login)
                        }
                        HStack{
                            Text("Imię i nazwisko")
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(userData[0].name)
                        }
                        HStack{
                            Text("Data urodzenia")
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(userData[0].birthdayDate)
                        }
                        HStack{
                            Text("Pesel")
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(userData[0].pesel)
                        }
                        HStack{
                            Text("Email")
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(userData[0].email)
                        }
                        
                    }
                }else{
                    Section{
                        HStack{
                            Text("Loading")
                                .foregroundColor(Color.gray)
                            Spacer()
                            
                        }
                    }
                }
                Section {
                    NavigationLink(
                        destination: NewPasswordView()){
                        Text("Zmień hasło")
                                .gradientForeground(colors:  [.purple,.blue])
                    }
                    NavigationLink(
                        destination: NewData()){
                        Text("Zmień nazwę użytkownika")
                                .gradientForeground(colors:  [.purple,.blue])
                    }
                    NavigationLink(
                        destination: eMailView()){
                        Text("Zmień E-mail")
                            .gradientForeground(colors:  [.purple,.blue])
                    }
                }
                
                
                Section {
                    HStack{
                        Text("Usuń konto")
                            .gradientForeground(colors:  [.red])
                        NavigationLink(destination:
                                        DeleteView()) {
                                EmptyView()
                              }
                              .frame(width: 0)
                              .opacity(0)
                        Spacer()
                        Image(systemName: "trash").foregroundColor(.gray)
                    }
                }
                
                Section {
                    Button(action: {
                        withAnimation {
                            userAuth.logout()
                    }
                    }){
                        HStack{
                            Text("Wyloguj się!")
                                .gradientForeground(colors:  [.purple,.blue])
                            Spacer()
                            Image(systemName: "figure.walk").foregroundColor(.gray)
                        }
                    }
                }
                
                Section {
                    HStack{
                        Text("O Aplikacji")
                            .gradientForeground(colors:  [.gray])
                        NavigationLink(destination: AboutView()) {
                                EmptyView()
                              }
                              .frame(width: 0)
                              .opacity(0)
                        Spacer()
                        Image(systemName: "info.circle").foregroundColor(.gray)
                    }
                }

            }
            .padding(.horizontal, -5)
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Ustawienia")
        }
        .onAppear(perform: {
            onLoad()
        })
        .alert(isPresented: $errorAction){
            Alert(title: Text(errorname),
                message: Text(errordetails),
                dismissButton: Alert.Button.default(
                    Text("Zamknij"), action: { userAuth.logout() }
                )
            )
        }
        .navigationBarTitle("Powrót")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
