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
                if let response = try? JSONDecoder().decode(PrescriData.self, from: data) {
                    DispatchQueue.main.async {
                        self.model[0] = response
                        print(model[0])
                    }
                    return
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
                        //            AsyncImage(url: URL(string: cardDetail.image)!,
                        //                           placeholder: { Text("Loading ...") },
                        //                           image: { Image(uiImage: $0).resizable()})
                    }.aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .shadow(radius: 7)
                    .padding(.top, -140.0)
                    .padding()
                    if model.isEmpty == true{
                    
                    }else{
                    List {
                        Section{
                            Text(model[0].description ?? "Desc")
                                .font(.title)
                                .foregroundColor(.primary)
                            
                            HStack {
                                Text(doctor)
                                Spacer()
                                Text(model[0].createdDate ?? "DAte")
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
                    }
                }.background(Color(UIColor(named: "GrayColor")!))
            }.onAppear(perform: {
                onLoad()
            })
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Wróć do listy!", displayMode: .inline)
        }
    }
}

//struct PrescriDetails_Previews: PreviewProvider {
//    static var previews: some View {
////        PrescriDetails(cardDetail: )
//        
//    }
//}
