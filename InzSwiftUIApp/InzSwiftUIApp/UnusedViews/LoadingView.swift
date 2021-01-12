//
//  LoadingView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 06/12/2020.
//

import SwiftUI

struct Loading: View {
    @State private var shouldAnimate = false
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        let gradient_invert = LinearGradient(gradient: colors, startPoint: .topTrailing, endPoint: .bottomTrailing)
        HStack {
            Circle()
                .fill(gradient)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.2)
                .animation(Animation.easeInOut(duration: 0.2).repeatForever())
            Circle()
                .fill(gradient_invert)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.2)
                .animation(Animation.easeInOut(duration: 0.2).repeatForever().delay(0.1))
            Circle()
                .fill(gradient)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.2)
                .animation(Animation.easeInOut(duration: 0.2).repeatForever().delay(0.2))
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
}

struct LoadingView: View{
    var body: some View {
        ZStack{
            Color(UIColor(named: "Color")!)
            VStack{
                Text("Ładowanie")
                Loading()
            }
        }.frame(width: 200.0, height: 100.0, alignment: .leading)
        .cornerRadius(20)
        .shadow(radius: 40)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
