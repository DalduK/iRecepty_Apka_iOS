//
//  UserAuth.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import Combine

class UserAuth: ObservableObject {
    @Published var isLoggeddin = false
    @Published var token: String = ""
    
    func logout(){
        self.isLoggeddin = false
        self.token = ""
    }
    
    func login(){
        self.isLoggeddin = true
    }
    
    func setToken(token:String){
        self.token = token
    }
    
    
}
