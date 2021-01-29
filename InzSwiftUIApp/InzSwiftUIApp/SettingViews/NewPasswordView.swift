//
//  NewPasswordView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 08/01/2021.
//

import SwiftUI
import CryptoKit

struct NewPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @EnvironmentObject var userAuth: UserAuth
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
    @State var Confirmed: Bool = false
        
    var errorActionSheet: ActionSheet {
        ActionSheet(title: Text(errorname), message: Text(errordetails), buttons: [.default(Text("Potwierdź"))])
    }
    
    func changePassword(oldPassword: String, newPassword: String){
        let oldpass = SHA256.hash(data: Data(oldPassword.utf8))
        let hashString = oldpass.compactMap { String(format: "%02x", $0) }.joined()
        let newpass = SHA256.hash(data: Data(newPassword.utf8))
        let hashString2 = newpass.compactMap { String(format: "%02x", $0) }.joined()
        let json: [String: Any] = ["oldPassword": hashString,
                                   "newPassword": hashString2]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "https://recepty.eu.ngrok.io/api/user/password") else {
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
                    withAnimation{
                        Confirmed.toggle()
                    }
                }
            }else {
                loadingAction = false
                errorname = "Dane nie zostały zmienione"
                errordetails = "Hasło nie zostało przesłane, spróbuj później"
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
                
                Image("Password")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Stare hasło",text:$oldPassword).textContentType(.emailAddress)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Nowe Hasło",text:$newPassword).textContentType(.emailAddress)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                ZStack{
                    Button(action: {
                        if newPassword != oldPassword && isValidPassword(newPassword){
                        withAnimation {
                            loadingAction.toggle()
                            changePassword(oldPassword: oldPassword, newPassword: newPassword)
                        }
                        }else{
                            loadingAction = false
                            errorname = "Dane nie zostały zmienione"
                            errordetails = "Podaj różne hasła"
                            errorAction = true
                        }
                    }){
                        Text("Zresetuj Hasło !")
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
        .actionSheet(isPresented: $errorAction, content: {
            return self.errorActionSheet
        })
        .alert(isPresented: $Confirmed){
            Alert(title: Text("Konto usunięte"),
                message: Text("Potwierdź przyciskiem, aby skorzystać z konta zaloguj się ponownie"),
                dismissButton: Alert.Button.default(
                    Text("Zakończ"), action: { userAuth.logout() }
                )
            )
        }
        .navigationBarTitle("Zmień hasło", displayMode: .inline)
        .padding(.top, 10)
    }
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}
