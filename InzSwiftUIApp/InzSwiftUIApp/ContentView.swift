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
        GeometryReader { geo in
            if !userAuth.isLoggeddin {
                LoginView()
            } else {
                HomeView()
                    .padding(.top)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserAuth())
    }
}
