//
//  RegisterView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI
import CryptoKit
import Combine


struct RegisterView: View {
    @State private var userName: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var pesel: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State var errorname: String = ""
    @State var errordetails: String = ""
    @State var errorAction = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.openURL) var openURL
    @EnvironmentObject var userAuth: UserAuth
    @State private var rules = false
    @State var loadingAction: Bool = false
    @State var Confirmed: Bool = false
    
    var noPassword: ActionSheet {
        ActionSheet(title: Text(errorname), message: Text(errordetails), buttons: [.default(Text("Potwierdź"))])
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool{
        let passRegex = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return passRegex.evaluate(with: password)
    }
    
    func limitText(_ upper: Int) {
        if pesel.count > upper {
            pesel = String(pesel.prefix(upper))
        }
    }
    
    
    func register(login: String, password: String, email: String){
        let pass = SHA256.hash(data: Data(password.utf8))
        let hashString = pass.compactMap { String(format: "%02x", $0) }.joined()
        let json: [String: Any] = ["login": login,
                                   "password": hashString,
                                   "email" : email]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "https://recepty.eu.ngrok.io/register") else {
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
                loadingAction = false
                errorAction = false
                let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                DispatchQueue.main.async {
                    userAuth.setToken(token: dataJSON?["token"] as! String, userName: userName)
                    print(userAuth.token)
                    withAnimation{
                        Confirmed.toggle()
                    }
                }
            }else {
                errorname = "Błąd Rejestracji"
                errordetails = "Spróbuj ponownie"
                loadingAction = false
                errorAction = true
            }
            
        }
        task.resume()
    }
    
    var body: some View {
    let colors = Gradient(colors: [.purple,.blue])
    let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        ZStack{
            ScrollView{
            VStack {
                Image("Register")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                HStack {
                    Image(systemName: "person.crop.circle").foregroundColor(.gray)
                    TextField("Imię",text:$name).autocapitalization(.none)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "person.crop.circle.fill").foregroundColor(.gray)
                    TextField("Nazwisko",text:$surname).autocapitalization(.none)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "person").foregroundColor(.gray)
                    TextField("Nazwa użytkownika",text:$userName).autocapitalization(.none)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray)
                    TextField("Email",text:$email).autocapitalization(.none)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                HStack {
                    Image(systemName: "person.fill.checkmark").foregroundColor(.gray)
                    TextField("Pesel",text:$pesel).textContentType(.oneTimeCode).keyboardType(.numberPad) .onReceive(Just(pesel)) { _ in limitText(11) }
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Hasło",text:$password).textContentType(.password).autocapitalization(.none)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Powtórz hasło",text:$password2).textContentType(.password).autocapitalization(.none)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                HStack{
                Button("Potwierdź regulamin") {
                    UIApplication.shared.open(URL(string: "https://gist.github.com/DalduK/81ad2174ccfe6f7580102e79c46378d9")!, options: [:], completionHandler: nil)
                        }
                Spacer()
                    Toggle("", isOn: $rules).labelsHidden()
                }.padding(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                
                ZStack{
                    Button(action: {
//                        if userName == "" || nameAndSurname == "" || pesel == ""{
                        if userName == "" || name == "" || surname == ""{
                            errorname = "Nazwa użytkownika lub imię i nazwisko są puste"
                            errordetails = "Podaj poprawne dane"
                            self.errorAction.toggle()
                        }
                        else{
                            if email == ""{
                                errorname = "Adres email pusty"
                                errordetails = "Podaj poprawny adres"
                                self.errorAction.toggle()
                            }
                            else if isValidEmail(email) == true {
                                errorname = "Adres email niepoprawny"
                                errordetails = "Podaj poprawny adres"
                                self.errorAction.toggle()
                            }
                            else if pesel.count != 11 {
                                errorname = "Pesel powinien mieć 11 znaków"
                                errordetails = "Podaj poprawny pesel"
                                self.errorAction.toggle()
                            }
                            else{
                                if (password != "" || password2 != ""){
                                    if isValidPassword(password){
                                    if password == password2{
                                        if rules == true{
                                            loadingAction = true
                                            register(login: userName, password: password, email: email)
                                        }else{
                                            errorname = "Potwierdz regulamin"
                                            errordetails = "Bez potwierdzenia regulaminu nie założysz konta!"
                                            self.errorAction.toggle()
                                        }
                                    }
                                    else{
                                        errorname = "Hasła są różne"
                                        errordetails = "Podaj poprawne hasło"
                                        self.errorAction.toggle()
                                    }}
                                    else{
                                        errorname = "Hasło nie spełnia wymagań"
                                        errordetails = "Podaj hasło które posiada 8 znaków, jedną liczbę, jedną wielką literę i jeden znak specjalny !"
                                        self.errorAction.toggle()
                                    }
                                }
                                else{
                                    errorname = "Puste hasło"
                                    errordetails = "Podaj poprawne hasło"
                                    self.errorAction.toggle()
                                }
                            }
                        }
                    }){
                        Text("Zarejestruj się")
                            .padding()
                            .background(gradient)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical,5)
            }
            }
            if loadingAction == true{
                LoadingView()
            }
            
        }
        .navigationBarTitle("Utwórz konto", displayMode: .inline)
        .actionSheet(isPresented: $errorAction, content: {
                return self.noPassword
        })
        .alert(isPresented: $Confirmed){
            Alert(title: Text("Konto zostało utworzone, sprawdź maila :)"))
        }
        .padding(.horizontal)
    }
    
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
