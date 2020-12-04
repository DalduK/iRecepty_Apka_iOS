//
//  PassView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct PassView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var userName: String = ""
    @State var password: String = ""
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        ZStack{
            VStack {
                Text("Przypomnij hasło")
                    .bold()
                    .font(.title)
                
                Text("Podaj mail powiązany z kontem")
                
                Image("Password")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray)
                    TextField("Email",text:$userName)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                ZStack{
                    Button(action: {
                        withAnimation {
                            
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
        .padding(.horizontal)
    }
    
}

struct PassView_Previews: PreviewProvider {
    static var previews: some View {
        PassView()
    }
}