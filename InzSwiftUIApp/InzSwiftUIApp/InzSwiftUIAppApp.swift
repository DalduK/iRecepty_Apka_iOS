//
//  InzSwiftUIAppApp.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

@main
struct InzSwiftUIAppApp: App {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var userAuth = UserAuth()
    @AppStorage("Mode") private var isDarkMode = 0
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userAuth)
        }
    }
}
