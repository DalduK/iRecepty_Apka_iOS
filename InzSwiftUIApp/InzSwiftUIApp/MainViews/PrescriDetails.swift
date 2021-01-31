//
//  ReceptDetails.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 02/01/2021.
//

import SwiftUI

struct PrescriDetails: View {
    var cardID: String
    var userAuth: UserAuth
    var doctor: String
    @State var model = [PrescriData]()
    @State var didAppear = false
    @State var appearCount = 0

    
    func onLoad() {
        if didAppear == false {
            appearCount += 1
            getHomeData(id: cardID)
        }
        didAppear = true
    }
    
    func getHomeData(id: String) {
        guard let url = URL(string: "https://recepty.eu.ngrok.io/api/prescription/" + id) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + userAuth.getToken(), forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data")
            let str = String(decoding: data!, as: UTF8.self)
            print(str)
            print("request")
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PrescriData.self, from: data)
                    model.append(response)
                }catch{
                    print("Couldn't parse data as \(PrescriData.self):\n\(error)")
                }
            }
        }.resume()
    }
    
    var body: some View {
        GeometryReader{ (proxy : GeometryProxy) in
            VStack {
                ScrollView{
                    Image("Gradient")
                        .resizable()
                        .frame(width: proxy.size.width, height:proxy.size.height/2.4 , alignment: .topLeading)
                    ZStack{
                        Color.white
                        Image(uiImage: generateQRCode(from: cardID))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .padding(.all, 30.0)
                    }.aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .shadow(radius: 7)
                    .padding(.top, -140.0)
                    .padding()
                    if model.isEmpty == true{
                    
                    }else{
                    List {
                        Section{
                            Text(model[0].shortDescription ?? "Desc")
                                .font(.title)
                                .foregroundColor(.primary)
                            
                            HStack {
                                Text(doctor)
                                Spacer()
                                Text(model[0].createdDate)
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            
                            HStack {
                                Text("Recepta aktywna do:")
                                Spacer()
                                Text(model[0].expiration ?? "Data Zakończenia")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        
                        
                        Text("Rozpis Leków")
                            .font(.title2)
                        Text("Dawkowanie")
                        
                        ForEach(model[0].medications, id: \.name) { drug in
                            HStack{
                                Text(drug.name)
                                Spacer()
                                Text(String(drug.amount) + " / " + String(drug.amountLeft))
                            }
                        }
                        
                        Section{
                            Text("Opis recepty").font(.title2)
                            
                            Text(model[0].description ?? "Brakuje opisu recepty")
                        }
                        
                    }.frame(width: proxy.size.width - 5, height: proxy.size.height - 50, alignment: .center)
                    .listStyle(InsetGroupedListStyle())
                    }
                }.background(Color(UIColor(named: "GrayColor")!))
            }.onAppear(perform: {
                onLoad()
            })
            .padding(.bottom, 50)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Wróć do listy!", displayMode: .inline)
        }
    }
}

