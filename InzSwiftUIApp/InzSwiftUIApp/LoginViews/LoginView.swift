//
//  LoginView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct Login: Codable {
    var refresh: String
    var access: String
}

struct LoginView: View {
    @State var userName: String = ""
    @State var password: String = ""
    @State var isShowing: Bool = true
    @EnvironmentObject var userAuth: UserAuth
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    
    var notLogged: ActionSheet {
        ActionSheet(title: Text("Błąd Logowania"), message: Text("Spróbuj ponownie"), buttons: [.cancel()])
    }
    
    func login(login: String, password: String){
        let json: [String: Any] = ["username": login,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "https:/31816a3ddc2b.ngrok.io/api/token/") else {
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
            print(statusCode)
            if statusCode == 200{
                errorAction = false
                let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                DispatchQueue.main.async {
                    userAuth.setToken(token: dataJSON?["access"] as! String, userName: userName)
                    withAnimation{
                        userAuth.login()
                    }
                }
            }else {
                loadingAction = false
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
                    
                    Text("Zaloguj się !")
                    
                    Image("Login")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    HStack {
                        Image(systemName: "person").foregroundColor(.gray)
                        TextField("Email",text:$userName).autocapitalization(.none)
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                    )
                    .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                    
                    HStack {
                        Image(systemName: "lock").foregroundColor(.gray)
                        SecureField("Password",text:$password)
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
                            loadingAction = true
                            login(login: userName, password: password)
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
                    LoadingView()
                }
            }
            .navigationTitle("Login")
            .actionSheet(isPresented: $errorAction, content:{
                            return self.notLogged
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
