//
//  RegisterView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct RegisterView: View {
    @State var userName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State var showNoPasswordView = false
    @State var showWrongPasswordView = false
    @State var error = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var userAuth: UserAuth
    @State private var rules = false
    
    var noPassword: ActionSheet {
        ActionSheet(title: Text("Puste Hasło"), message: Text("Podaj poprawne hasło"), buttons: [.cancel()])
    }
    
    var wrongPassword: ActionSheet {
        ActionSheet(title: Text("Hasła są różne"), message: Text("Podaj poprawne hasło"), buttons: [.cancel()])
    }
    
    var regulations: ActionSheet {
        ActionSheet(title: Text("Potwierdz regulamin !"), message: Text("Potwierdz regulamin aby utworzyc konto"), buttons: [.cancel()])
    }
    
    var body: some View {
    let colors = Gradient(colors: [.purple,.blue])
    let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        ZStack{
            VStack {
                Image("Register")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                HStack {
                    Image(systemName: "person").foregroundColor(.gray)
                    TextField("Nick",text:$userName)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray)
                    TextField("Email",text:$email)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Password",text:$password).textContentType(.password)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Repeat",text:$password2).textContentType(.password)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                Toggle("Potwierdź regularmin", isOn: $rules)
                    .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                
                ZStack{
                    Button(action: {
                        if (password != "" || password2 != ""){
                            if password == password2{
                                print(password2)
                                self.mode.wrappedValue.dismiss()
                            }
                            else{
                                self.showWrongPasswordView.toggle()
                                self.error.toggle()
                            }}
                        else{
                            self.error.toggle()
                            self.showNoPasswordView.toggle()
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
        .navigationBarTitle("Utwórz konto", displayMode: .inline)
        .actionSheet(isPresented: $error, content: {
            if showWrongPasswordView == true{
                      return self.wrongPassword
            }else{
                return self.noPassword
            }
        })
        .padding(.horizontal)
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
