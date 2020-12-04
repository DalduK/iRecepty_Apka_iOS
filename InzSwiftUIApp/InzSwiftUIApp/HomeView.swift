//
//  HomeView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct HomeView: View {
    @State var index = 0
    var body: some View {
        GeometryReader { gx in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {}){
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .frame(width: 25, height: 25)
                        }
                        
                        Spacer()
                        
                        Button(action: {}){
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding()
                    
                    HStack{
                        Text("Witaj Przemek")
                            .font(.system(size:30, weight: .bold))
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack(spacing: 20)
                        {
                            ForEach(cardsData) { cards in
                                GeometryReader { geometry in
                                    CardView(
                                        image: cards.image,
                                        data: cards.data,
                                        recepta: cards.recepta,
                                        lekarz: cards.lekarz
                                    )
                                    .rotation3DEffect(.degrees(0), axis: (x: 40, y: 0, z: 0))
                                }
                                .padding()
                                .frame(width: gx.size.width, height: gx.size.height * 0.8)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}