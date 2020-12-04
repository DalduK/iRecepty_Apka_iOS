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
    @EnvironmentObject var userAuth: UserAuth
    @State private var rules = false
    var body: some View {
    let colors = Gradient(colors: [.purple,.blue])
    let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        ZStack{
            VStack {
                Text("Zarejestruj się!")
                    .bold()
                    .font(.title)
                
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
                    SecureField("Email",text:$userName)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    TextField("Password",text:$userName)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Password",text:$userName)
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
                        withAnimation {
                            userAuth.login()
                    }
                    }){
                        Text("Zarejestruj się")
                            .padding()
                            .background(gradient)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top,5)
            }
        }
        .padding(.horizontal)
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
