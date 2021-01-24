//
//  NewData.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 08/01/2021.
//

import SwiftUI

struct NewData: View {
    @State private var userName: String = ""
    @State private var date = Date()
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
            List{
                Section {
                    Text("Dane użytkownika")
                        .font(.headline)
                        .fontWeight(.bold)
                        
                }
                
                
                
                Section {
                    HStack{
                        Text("Nazwa użytkownika")
                            .foregroundColor(Color.gray)
                        Spacer()
                    Text("dalduk")
                    }
                    HStack{
                        Text("Imię i nazwisko")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("Przemysław Woźny")
                    }
                    HStack{
                        Text("Data urodzenia")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("07/02/1998")
                    }
                    HStack{
                        Text("Nazwa użytkownika")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("Pesel")
                    }
                    HStack{
                        Text("Email")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text("dalduk14@gmail.com")
                    }
                    
                }
                
                Section {
                    Text("Nazwa użytkownika")
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack{
                    HStack {
                        Image(systemName: "lock").foregroundColor(.gray)
                        SecureField("Nazwa użytkownika",text:$userName).textContentType(.emailAddress)
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                    )
                    .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                        Button(action: {}){
                            Image(systemName: "chevron.right").foregroundColor(.white)
                                .padding(.init(top: 12, leading: 12, bottom: 13, trailing: 12))
                                .background(gradient)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                Section {
                    Text("Imię i nazwisko")
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack{
                        HStack {
                            Image(systemName: "lock").foregroundColor(.gray)
                            SecureField("Imię",text:$userName).textContentType(.emailAddress)
                        }
                        .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                        )
                        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                            Button(action: {}){
                                Image(systemName: "chevron.right").foregroundColor(.white)
                                    .padding(.init(top: 12, leading: 12, bottom: 13, trailing: 12))
                                    .background(gradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                    }
                    HStack{
                        HStack {
                            Image(systemName: "lock").foregroundColor(.gray)
                            SecureField("Nazwisko",text:$userName).textContentType(.emailAddress)
                        }
                        .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(gradient,lineWidth: 5)
                        )
                        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                            Button(action: {}){
                                Image(systemName: "chevron.right").foregroundColor(.white)
                                    .padding(.init(top: 12, leading: 12, bottom: 13, trailing: 12))
                                    .background(gradient)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                    }
                }

            }
            .padding(.horizontal, -5)
            .navigationBarTitle("Dane użytkownika")
            .listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct NewData_Previews: PreviewProvider {
    static var previews: some View {
        NewData()
    }
}
