//
//  FristTimeView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 28/01/2021.
//

import SwiftUI

struct FristTimeView: View {
    var body: some View {
        GeometryReader{ (proxy : GeometryProxy) in
            VStack {
                ScrollView{
                    Image("Gradient")
                        .resizable()
                        .frame(width: proxy.size.width, height:proxy.size.height/2.4 , alignment: .topLeading)
                    ZStack{
                        Color.white
                        Text("Tutaj wyświetlany będzie QR kod").foregroundColor(.black)
                    }.frame(width: 300, height: 300)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .shadow(radius: 7)
                    .padding(.top, -140.0)
                    .padding()
                    
                    List {
                        Section{
                            Text("Krótki opis recepty znajdować się będzie tutaj")
                                .font(.title)
                                .foregroundColor(.primary)
                            
                            HStack {
                                Text("Tutaj będą widniały dane o doktorze")
                                Spacer()
                                Text("Data wydania recepty znajdować się będzie tutaj")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        
                        
                        Text("Opis Recepty")
                            .font(.title2)
                        Text("Dawkowanie")
                        
                        
                        HStack{
                            Text("Apap")
                            Spacer()
                            Text("2 razy dziennie")
                        }
                        HStack{
                            Text("Witamina C")
                            Spacer()
                            Text("3 razy dziennie")
                        }
                        HStack{
                            Text("Lek na kaszel")
                            Spacer()
                            Text("2 razy dziennie")
                        }
                        
                        Section{
                            Text("Opis recepty").font(.title2)
                            
                            Text("Tutaj znajdować będzie się opis recepty")
                        }
                    }.frame(width: proxy.size.width - 5, height: proxy.size.height - 50, alignment: .center)
                    .listStyle(InsetGroupedListStyle())
                    }
                }.background(Color(UIColor(named: "GrayColor")!))
            }
        .padding(.bottom, 50)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Wróć do listy!", displayMode: .inline)
    }
}

struct FristTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FristTimeView()
    }
}
