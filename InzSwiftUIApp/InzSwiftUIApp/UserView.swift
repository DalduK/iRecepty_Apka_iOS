//
//  UserView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        NavigationView{
            List{
                Section {
                    Text("Nazwa użytkownika")
                    Text("Data urodzin")
                    Text("Nazwa użytkownika")
                    Text("Data urodzin")
                }
                
                Section {
                    Text("Nazwa użytkownika")
                    Text("Data urodzin")
                    Text("Nazwa użytkownika")
                    Text("Data urodzin")
                }
            }.navigationBarTitle("Ustawienia")
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
