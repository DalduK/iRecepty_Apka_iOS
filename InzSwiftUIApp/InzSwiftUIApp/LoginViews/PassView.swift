//
//  PassView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI



struct PassView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email: String = ""
    @State var isValid: Bool = false
    @State var text = ""
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailPred.evaluate(with: email)
    }
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        ZStack{
            VStack {
                Image("Password")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("Podaj mail powiązany z kontem")
                
                
                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray)
                    TextField("Email",text:$email).textContentType(.emailAddress).keyboardType(.emailAddress)
                }
                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                )
                .padding(.init(top: 10, leading: 15, bottom: 5, trailing: 15))
                
                ZStack{
                    Button(action: {
                        withAnimation {
                            isValid = isValidEmail(email)
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
                
                Spacer()
            }
        }.actionSheet(isPresented: $isValid, content:{
                    ActionSheet(title: Text("Format maila nie jest poprawny"), message: Text("Ponownie podaj mail"), buttons: [.cancel()])
        })
        .navigationBarTitle("Przypomnij hasło", displayMode: .inline)
        .padding(.top, 10)
        
    }
    
}

struct PassView_Previews: PreviewProvider {
    static var previews: some View {
        PassView()
    }
}
