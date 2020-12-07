//
//  MenuView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 07/12/2020.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Konto użytkownika")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top,100)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Powiadomienia")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top,30)
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Ustawienia")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top,30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
            
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
