//
//  NewData.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 08/01/2021.
//

import SwiftUI

struct NewData: View {
    @State private var userName: String = ""
    @State private var date = Date()
    @EnvironmentObject var userAuth: UserAuth
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
    
    func changeUsername(username: String){
        let json: [String: Any] = ["login": username]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "https://recepty.eu.ngrok.io/api/user/login") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + userAuth.getToken(), forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            var statusCode: Int = 0
            guard let _ = data, let response = response, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            print("StatusCode: \(statusCode)")
            if statusCode == 200{
                errorAction = false
                DispatchQueue.main.async {
                    print(userAuth.getToken())
                    withAnimation{
                        userAuth.logout()
                    }
                }
            }else {
                loadingAction = false
                errorname = "Dane nie zostały zmienione"
                errordetails = "Podaj dostępną nazwę"
                errorAction = true
            }
            
        }
        task.resume()
    }
    
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
            List{
                Section {
                    Text("Dane użytkownika")
                        .font(.headline)
                        .fontWeight(.bold)
                        
                }
                
                
                
                Section {
                    HStack{
                        Text("Nazwa użytkownika")
                            .foregroundColor(Color.gray)
                        Spacer()
                    Text("dalduk")
                    }
                    HStack{
                        Text("Imię i nazwisko")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("Przemysław Woźny")
                    }
                    HStack{
                        Text("Data urodzenia")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("07/02/1998")
                    }
                    HStack{
                        Text("Nazwa użytkownika")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("Pesel")
                    }
                    HStack{
                        Text("Email")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("dalduk14@gmail.com")
                    }
                    
                }
                
                Section {
                    Text("Nazwa użytkownika")
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack{
                    HStack {
                        Image(systemName: "lock").foregroundColor(.gray)
                        SecureField("Nazwa użytkownika",text:$userName).textContentType(.emailAddress)
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                    )
                    .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                        Button(action: {
                            changeUsername(username: userName)
                        }){
                            Image(systemName: "chevron.right").foregroundColor(.white)
                                .padding(.init(top: 12, leading: 12, bottom: 13, trailing: 12))
                                .background(gradient)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                Section {
                    Text("Imię i nazwisko")
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack{
                        HStack {
                            Image(systemName: "lock").foregroundColor(.gray)
                            SecureField("Imię",text:$userName).textContentType(.emailAddress)
                        }
                        .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                        )
                        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                            Button(action: {}){
                                Image(systemName: "chevron.right").foregroundColor(.white)
                                    .padding(.init(top: 12, leading: 12, bottom: 13, trailing: 12))
                                    .background(gradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                    }
                    HStack{
                        HStack {
                            Image(systemName: "lock").foregroundColor(.gray)
                            SecureField("Nazwisko",text:$userName).textContentType(.emailAddress)
                        }
                        .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                        )
                        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                            Button(action: {}){
                                Image(systemName: "chevron.right").foregroundColor(.white)
                                    .padding(.init(top: 12, leading: 12, bottom: 13, trailing: 12))
                                    .background(gradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                    }
                }

            }
            .padding(.horizontal, -5)
            .navigationBarTitle("Dane użytkownika")
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct NewData_Previews: PreviewProvider {
    static var previews: some View {
        NewData()
    }
}
