//
//  eMailView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 08/01/2021.
//

import SwiftUI

struct eMailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var eMail: String = ""
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        ZStack{
            VStack {
                
                Image("email")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Podaj nowy adres email !")
                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray)
                    TextField("Nowy eMail",text:$eMail).textContentType(.emailAddress)
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
                        Text("Zmień eMail !")
                            .padding()
                            .background(gradient)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top,5)
                
                Spacer()
            }
        }
        .navigationBarTitle("Zmień maila!", displayMode: .inline)
        .padding(.top, 10)
    }
}

struct eMailView_Previews: PreviewProvider {
    static var previews: some View {
        eMailView()
    }
}
