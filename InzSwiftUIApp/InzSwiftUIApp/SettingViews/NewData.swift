//
//  NewData.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 08/01/2021.
//

import SwiftUI

struct NewData: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var userName: String = ""
    @State private var date = Date()
    @EnvironmentObject var userAuth: UserAuth
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
    @State var Confirmed: Bool = false
    
    func changeUsername(username: String){
        let json: [String: Any] = ["login": username]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "https://recepty.eu.ngrok.io/api/user/login") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                loadingAction = false
                DispatchQueue.main.async {
                    Confirmed.toggle()
                    userAuth.setUserName(name: username)
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
        ZStack{
            VStack {
                
                Image("changename")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .padding(.bottom,40)
                Text("Podaj nową nazwę użytkownika!")
                HStack {
                    Image(systemName: "person").foregroundColor(.gray)
                    TextField("Nowa nazwa",text:$userName).textContentType(.emailAddress)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                
                ZStack{
                    Button(action: {
                        withAnimation {
                            loadingAction.toggle()
                            changeUsername(username: userName)
                    }
                    }){
                        Text("Zmień nazwę!")
                            .padding()
                            .background(gradient)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top,5)
                
                Spacer()
            }
            if loadingAction == true{
                LoadingView().shadow(radius: 20)
            }
        }
        .alert(isPresented: $Confirmed){
            Alert(title: Text("Nazwa konta zmieniona"),
                message: Text("Konto zostało zmienione!"),
                dismissButton: Alert.Button.default(
                    Text("Dalej"), action: { self.presentationMode.wrappedValue.dismiss() }
                )
            )
        }
        .navigationBarTitle("Zmień maila!", displayMode: .inline)
        .padding(.top, 10)
    }
}

struct NewData_Previews: PreviewProvider {
    static var previews: some View {
        NewData()
    }
}
