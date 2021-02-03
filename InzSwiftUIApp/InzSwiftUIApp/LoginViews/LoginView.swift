//
//  LoginView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI
import CryptoKit

struct Login: Codable {
    var refresh: String
    var access: String
}

struct LoginView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State var isShowing: Bool = true
    @EnvironmentObject var userAuth: UserAuth
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
    
    var errorActionSheet: ActionSheet {
        ActionSheet(title: Text(errorname), message: Text(errordetails), buttons: [.default(Text("Potwierdź"))])
    }
    
    func isValidPassword(_ password: String) -> Bool{
        let passRegex = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return passRegex.evaluate(with: password)
    }
    
    
    func login(login: String, password: String){
        let pass = SHA256.hash(data: Data(password.utf8))
        let hashString = pass.compactMap { String(format: "%02x", $0) }.joined()
        let json: [String: Any] = ["login": login,
                                   "password": hashString]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "https://recepty.eu.ngrok.io/login") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                DispatchQueue.main.async {
                    userAuth.setToken(token: dataJSON?["token"] as! String, userName: userName)
                    userAuth.setUserName(name:userName)
                    print(userAuth.getToken())
                    withAnimation{
                        userAuth.login()
                    }
                }
            }else {
                loadingAction = false
                errorname = "Nie istnieje taki użytkownik"
                errordetails = "Podaj poprawne dane"
                errorAction = true
            }
            
        }
        task.resume()
    }
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        NavigationView {
            GeometryReader { geometry in
            ZStack{
                VStack {
                    Text("Login")
                        .bold()
                        .font(.title)
                    
                    Text("Zaloguj się za pomocą nazwy użytkownika!")
                    
                    Image("Login")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    HStack {
                        Image(systemName: "person").foregroundColor(.gray)
                        TextField("Nazwa użytkownika",text:$userName)
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                    )
                    .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                    
                    HStack {
                        Image(systemName: "lock").foregroundColor(.gray)
                        SecureField("Hasło",text:$password)
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                    )
                    .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                    
                    HStack {
                        NavigationLink(destination: PassView(),
                            label: {
                                Text("Przypomnij Hasło")
                            })
                            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                        
                        Spacer()
                        
                        NavigationLink(destination: RegisterView(),
                            label: {
                                Text("Utwórz konto")
                            })
                            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                    }
                    
                    ZStack{
                        Button(action: {
                            if userName == "" {
                                errorname = "Nazwa użytkownika lub imię i nazwisko są puste"
                                errordetails = "Podaj poprawne dane"
                                self.errorAction.toggle()
                            }else{
                                if (password != "") && isValidPassword(password){
                                loadingAction = true
                                
                                login(login: userName, password: password)
                                }
                                else{
                                    errorname = "Hasło jest niepoprawne"
                                    errordetails = "Proszę podać poprawne hasło"
                                    self.errorAction.toggle()
                                }
                            }
                        }){
                            Text("Zaloguj się")
                                .padding()
                                .background(gradient)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top,5)
                }
                if loadingAction == true{
                    LoadingView().shadow(radius: 20)
                }
            }
            .navigationTitle("Login")
            .actionSheet(isPresented: $errorAction, content:{
                            return self.errorActionSheet
            })
            .progressViewStyle(CircularProgressViewStyle())
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(.horizontal)
    }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserAuth())
    }
}
