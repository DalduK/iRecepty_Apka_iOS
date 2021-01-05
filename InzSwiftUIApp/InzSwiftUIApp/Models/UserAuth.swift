//
//  UserAuth.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import Combine

class UserAuth: ObservableObject {
    @Published var isLoggeddin = false
    
    func logout(){
        self.isLoggeddin = false
    }
    
    func login(){
        self.isLoggeddin = true
    }
    
    
}
