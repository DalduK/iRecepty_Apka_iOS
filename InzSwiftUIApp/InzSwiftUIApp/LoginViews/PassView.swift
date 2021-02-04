//
//  PassView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI



struct PassView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email: String = ""
    @State var text = ""
    @State var errorname: String = ""
    @State var errordetails: String = ""
    @State var errorAction = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var loadingAction: Bool = false
    @State var Confirmed: Bool = false
    
    var errAction: ActionSheet {
        ActionSheet(title: Text(errorname), message: Text(errordetails), buttons: [.default(Text("Potwierdź"))])
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailPred.evaluate(with: email)
    }
    
    
    
    
    func updateMail(email: String){
        let isValid = isValidEmail(email)
        print("MAIL")
        print(isValid)
        if isValid == true{
            errorname = "Niepoprawny mail"
            errordetails = "Podaj email w dobrym formacie"
            loadingAction = false
            errorAction = true
            return
        }
        let json: [String: Any] = ["email" : email]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "https://recepty.eu.ngrok.io/updatepass") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                loadingAction = false
                errorAction = false
                DispatchQueue.main.async {
                    withAnimation{
                        Confirmed.toggle()
                    }
                }
            }else {
                errorname = "Błąd Aktualizacji"
                errordetails = "Spróbuj ponownie, bądź sprawdź czy to poprawny mail"
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
            VStack {
                Image("Password")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("Podaj mail powiązany z kontem")
                
                
                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray)
                    TextField("Email",text:$email).textContentType(.emailAddress).keyboardType(.emailAddress)
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
                            updateMail(email: email)
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
                
                Spacer()
            }
            if loadingAction == true{
                LoadingView().shadow(radius: 20)
            }
        }.actionSheet(isPresented: $errorAction, content:{errAction})
        .alert(isPresented: $Confirmed){
            Alert(title: Text("Email wysłany"),
                message: Text("Aby zresetować hasło wejdź w link dostępny na poczcie!"),
                dismissButton: Alert.Button.default(
                    Text("Dalej"), action: { self.mode.wrappedValue.dismiss() }
                )
            )
        }
        .navigationBarTitle("Przypomnij hasło", displayMode: .inline)
        .padding(.top, 10)
        
    }
    
}

struct PassView_Previews: PreviewProvider {
    static var previews: some View {
        PassView()
    }
}
