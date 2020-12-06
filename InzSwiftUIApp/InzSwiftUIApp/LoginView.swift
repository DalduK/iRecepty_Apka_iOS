//
//  LoginView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct LoginView: View {
    @State var userName: String = ""
    @State var password: String = ""
    @State var isShowing: Bool = true
    @EnvironmentObject var userAuth: UserAuth
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
                        TextField("Email",text:$userName)
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
                    
                    HStack {
                        NavigationLink(destination: PassView(),
                            label: {
                                Text("Przypomnij Hasło")
                            })
                            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                        
                        Spacer()
                        
                        NavigationLink(destination: RegisterView(),
                            label: {
                                Text("Przypomnij Hasło")
                            })
                            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                    }
                    
                    ZStack{
                        Button(action: {
                            withAnimation {
                                userAuth.login()
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
            }
            .navigationTitle("Login")
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
