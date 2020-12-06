//
//  LoadingView.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 06/12/2020.
//

import SwiftUI

struct LoadingView: View {
    @State private var shouldAnimate = false
    var body: some View {
        let colors = Gradient(colors: [.purple,.blue])
        let gradient = LinearGradient(gradient: colors, startPoint: .bottomLeading, endPoint: .topTrailing)
        let gradient_invert = LinearGradient(gradient: colors, startPoint: .topTrailing, endPoint: .bottomTrailing)
        HStack {
            Circle()
                .fill(gradient)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            Circle()
                .fill(gradient_invert)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3))
            Circle()
                .fill(gradient)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6))
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
