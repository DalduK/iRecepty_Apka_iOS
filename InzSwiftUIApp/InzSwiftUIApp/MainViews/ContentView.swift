//
//  ContentView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var userAuth: UserAuth
    @State var showMenu = false
    var body: some View {
        if !userAuth.isLoggeddin {
            LoginView()
        } else {
            HomeView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserAuth())
    }
}
