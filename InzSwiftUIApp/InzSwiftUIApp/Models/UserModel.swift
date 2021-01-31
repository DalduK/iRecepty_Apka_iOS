//
//  UsersData.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 28/01/2021.
//

import Foundation


struct UserModel:  Hashable, Codable {
    var login: String
    var name: String
    var email: String
    var pesel: String
    var birthdayDate: String
}
