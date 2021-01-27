//
//  DeleteView .swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 09/01/2021.
//

import SwiftUI
import CryptoKit

struct DeleteView: View {
    @State private var accName: String = ""
    @State private var password: String = ""
    @EnvironmentObject var userAuth: UserAuth
    @State var errorAction: Bool = false
    @State var loadingAction: Bool = false
    @State var errorname = ""
    @State var errordetails = ""
    
    var errorActionSheet: ActionSheet {
        ActionSheet(title: Text(errorname), message: Text(errordetails), buttons: [.default(Text("Potwierdź"))])
    }
    
    func Delete(login: String, password: String){
        print("delete")
        guard let url = URL(string: "https://recepty.eu.ngrok.io/api/user/delete") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
//        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + userAuth.getToken(), forHTTPHeaderField: "Authorization")
        
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
                DispatchQueue.main.async {
                    withAnimation{
                        userAuth.logout()
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
        VStack{
            Text("Czy jesteś pewny że chcesz usunąć konto ?")
                .font(.title)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding()
            Text("Jeśli jesteś pewny wpisz twoją nazwę użytkownika i hasło, a następnie potwierdź przyciskiem poniżej. Pamiętaj, proces jest nieodwracalny")
                .multilineTextAlignment(.center)
                .padding()
            HStack {
                Image(systemName: "trash").foregroundColor(.gray)
                TextField("Nazwa użytkownika",text:$accName).textContentType(.emailAddress).keyboardType(.emailAddress)
            }
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.red,lineWidth: 5)
            )
            .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
            
            HStack {
                Image(systemName: "trash").foregroundColor(.gray)
                SecureField("Hasło",text:$accName)
            }
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.red,lineWidth: 5)
            )
            .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
            
            ZStack{
                Button(action: {
                    withAnimation {
                        
                    Delete(login: accName, password: password)
                }
                }){
                    Text("Usuń Konto")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.top,5)
            
        }.navigationBarTitle("Usuń konto!", displayMode: .inline)
    }
}

struct DeleteView__Previews: PreviewProvider {
    static var previews: some View {
        DeleteView()
    }
}
