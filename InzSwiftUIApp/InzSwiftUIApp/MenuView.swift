//
//  MenuView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 07/12/2020.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView{
        VStack(alignment: .leading){
            NavigationLink(destination: UserView()){
                HStack {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Konto użytkownika")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            .padding(.top, 70)
            }
//            HStack {
//                Image(systemName: "envelope")
//                    .foregroundColor(.gray)
//                    .imageScale(.large)
//                Text("Powiadomienia")
//                    .foregroundColor(.gray)
//                    .font(.headline)
//            }
//            .padding(.top,30)
            NavigationLink(destination: SettingsView()){
                HStack {
                    Image(systemName: "wrench.and.screwdriver")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Ustawienia")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.top,20)
            }
            Spacer()
            HStack {
                Image(systemName: "person.crop.circle.badge.xmark")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Wyloguj")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.bottom,20.0)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
            
    }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
