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
    @Published private var token: String = ""
    @Published private var userName: String = ""
    
    
    
    func logout(){
        self.isLoggeddin = false
        self.token = ""
        self.userName = ""
    }
    
    func login(){
        self.isLoggeddin = true
    }
    func setUserName(name:String){
        self.userName = name
    }
    
    
    func setToken(token:String, userName:String){
        self.token = token
        self.userName = userName
    }
    
    func getToken() -> String{
        return self.token
    }
    
    func getUserName() -> String{
        return self.userName
    }
    
    
}
