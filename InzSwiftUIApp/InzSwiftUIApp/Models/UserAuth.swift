//
//  UserAuth.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import Combine
import SwiftUI

class UserAuth: ObservableObject {
    @Published var isLoggeddin = false
    @Published var token: String = ""
    @Published var userName: String = ""
    @State var appearance = UserDefaults.standard
    
    
    func logout(){
        self.isLoggeddin = false
        self.token = ""
    }
    
    func login(){
        self.isLoggeddin = true
    }
    
    func setToken(token:String, userName:String){
        self.token = token
        self.userName = userName
    }
    
    
}
