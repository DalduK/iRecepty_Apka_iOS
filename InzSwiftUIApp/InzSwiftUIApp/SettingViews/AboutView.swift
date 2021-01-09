//
//  AboutView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 09/01/2021.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        GeometryReader{ (proxy : GeometryProxy) in
        VStack{
            List{
                Section{
                    Text("Aplikacja utworzona na potrzeby pracy inżynierskiej na uczelnię Politechnika Poznańska.").foregroundColor(.gray)
                    
                    Text("Wykonana została przez grupę: Przemysław Woźny, Jakub Florczak, Bartosz Porębski, Andrzej Skrobak.").foregroundColor(.gray)
                }
                
                Section{
                    Text("Aplikacja na platformę IOS: Przemysław Woźny")
                }.foregroundColor(.gray)
                
                Section{
                    Text("Aplikacja webowa: Jakub Florczak.")
                }.foregroundColor(.gray)
                
                Section{
                    Text("REST API: Bartosz Porębski.")
                }.foregroundColor(.gray)
                
                Section{
                    Text("Rozproszona baza danych: Jakub Florczak, Andrzej Skrobak.")
                }.foregroundColor(.gray)
                
                Section{
                    Text("Aplikacja utworzona w 2021.")
                }.foregroundColor(.gray)
                
            }.listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("O Aplikacji")
        }
            
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
