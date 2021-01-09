//
//  SettingsView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userAuth: UserAuth
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        Button(action: {
            withAnimation {
                userAuth.logout()
        }
        }){
            Text("Wyloguj się!")
                .padding()
                .background(gradient)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
