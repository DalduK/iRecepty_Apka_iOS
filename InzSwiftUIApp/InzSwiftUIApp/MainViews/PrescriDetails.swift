//
//  ReceptDetails.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct PrescriDetails: View {
    var cardDetail: Cards
    var body: some View {
        GeometryReader{ (proxy : GeometryProxy) in
            VStack {
                ScrollView{
                    Image("Gradient")
                        .resizable()
                        .frame(width: proxy.size.width, height:proxy.size.height/2.4 , alignment: .topLeading)
                    ZStack{
                        Color.white
                        Image(uiImage: generateQRCode(from: cardDetail.image))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .padding(.all, 30.0)
                        //            AsyncImage(url: URL(string: cardDetail.image)!,
                        //                           placeholder: { Text("Loading ...") },
                        //                           image: { Image(uiImage: $0).resizable()})
                    }.aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .shadow(radius: 7)
                    .padding(.top, -140.0)
                    .padding()
                    
                    
                    List {
                        Section{
                            Text(cardDetail.recepta)
                                .font(.title)
                                .foregroundColor(.primary)
                            
                            HStack {
                                Text(cardDetail.lekarz)
                                Spacer()
                                Text(cardDetail.data)
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
                    }.frame(width: proxy.size.width - 5, height: proxy.size.height - 50, alignment: .center)
                    .listStyle(InsetGroupedListStyle())
                }.background(Color(UIColor(named: "GrayColor")!))
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Wróć do listy!", displayMode: .inline)
        }
    }
}

struct PrescriDetails_Previews: PreviewProvider {
    static var previews: some View {
        PrescriDetails(cardDetail: cardsData[0])
        
    }
}
