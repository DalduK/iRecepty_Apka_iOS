//
//  UserView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var userAuth: UserAuth
    var body: some View {
        NavigationView{
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
                    NavigationLink(
                        destination: NewPasswordView()){
                        Text("Zmień hasło")
                                .gradientForeground(colors:  [.purple,.blue])
                    }
                    HStack{
                        Text("Zmień Dane")
                            .gradientForeground(colors:  [.purple,.blue])
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.gray)
                    }
                    HStack{
                        Text("Zmień E-mail")
                            .gradientForeground(colors:  [.purple,.blue])
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.gray)
                    }
                }
                
                Section {
                    HStack{
                        Text("Usuń konto")
                            .gradientForeground(colors:  [.red])
                        Spacer()
                        Image(systemName: "trash").foregroundColor(.gray)
                    }
                }
                
                Section {
                    Button(action: {
                        withAnimation {
                            userAuth.logout()
                    }
                    }){
                        HStack{
                            Text("Wyloguj się!")
                                .gradientForeground(colors:  [.purple,.blue])
                            Spacer()
                            Image(systemName: "figure.walk").foregroundColor(.gray)
                        }
                    }
                }
                
                Section {
                    HStack{
                        Text("O Aplikacji")
                            .gradientForeground(colors:  [.gray])
                        Spacer()
                        Image(systemName: "info.circle").foregroundColor(.gray)
                    }
                }

            }
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Ustawienia")
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
