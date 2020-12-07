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
        NavigationView{
            GeometryReader { geo in
                if !userAuth.isLoggeddin {
                    LoginView()
                } else {
                    ZStack(alignment: .leading){
                        HomeView()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .offset(x: self.showMenu ? geo.size.width/2 : 0)
                            .disabled(self.showMenu ? true : false)
                        if self.showMenu {
                            MenuView()
                                .frame(width: geo.size.width/2)
                                .transition(.move(edge: .leading))
                        }
                    }
                }
            }
            .navigationBarTitle("Witaj !", displayMode: .inline)
            .navigationBarItems(leading: (
                                Button(action: {
                                    withAnimation {
                                        self.showMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                }
                            ))
            .navigationBarHidden(userAuth.isLoggeddin ? false : true)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserAuth())
    }
}
