//
//  InzSwiftUIAppApp.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI

@main
struct InzSwiftUIAppApp: App {
    private let userAuth = UserAuth()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userAuth).disableAutocorrection(true).autocapitalization(.none)
        }
    }
}
