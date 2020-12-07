//
//  HomeView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

struct HomeView: View {
    @State var index = 0
    @State var alpha: Double = 1
    @State var blurBack: Int = 30
    var body: some View {
            GeometryReader { gx in
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack{
                        VStack {
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
//                        .blur(radius: CGFloat(blurBack))
//                        VStack{
//                            Text("Loading...")
//                            LoadingView()
//                        }
//                        .onAppear(perform: {
//                                  DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                                    self.alpha = 0
//                                    self.blurBack = 0
//                          }
//                        })
//                        .frame(width: gx.size.width / 2,
//                                               height: gx.size.height / 5)
//                        .background(Color.white)
//                        .foregroundColor(Color.primary)
//                        .cornerRadius(20)
//                        .opacity(alpha)
                    }
                }
                
            }
            
        }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        @Biding var showMenu = true
//        HomeView(showMenu: $showMenu)
//    }
//}
