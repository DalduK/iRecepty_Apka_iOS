//
//  DeleteView .swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 09/01/2021.
//

import SwiftUI

struct DeleteView: View {
    @State private var accName: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack{
            Text("Czy jesteś pewny że chcesz usunąć konto ?")
                .font(.title)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding()
            Text("Jeśli jesteś pewny wpisz twoją nazwę użytkownika i hasło, a następnie potwierdź przyciskiem poniżej. Pamiętaj, proces jest nieodwracalny")
                .multilineTextAlignment(.center)
                .padding()
            HStack {
                Image(systemName: "trash").foregroundColor(.gray)
                TextField("Nazwa użytkownika",text:$accName).textContentType(.emailAddress).keyboardType(.emailAddress)
            }
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.red,lineWidth: 5)
            )
            .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
            
            HStack {
                Image(systemName: "trash").foregroundColor(.gray)
                SecureField("Hasło",text:$accName)
            }
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color.red,lineWidth: 5)
            )
            .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
            
            ZStack{
                Button(action: {
                    withAnimation {
                        
                }
                }){
                    Text("Usuń Konto")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.top,5)
            
        }.navigationBarTitle("Usuń konto!", displayMode: .inline)
    }
}

struct DeleteView__Previews: PreviewProvider {
    static var previews: some View {
        DeleteView()
    }
}
