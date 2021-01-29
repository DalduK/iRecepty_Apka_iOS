//
//  UsersData.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 28/01/2021.
//

import Foundation


struct UserData:  Hashable, Codable {
    var login: String
    var name: String
    var email: String
    var pesel: String
    var birthdayDate: String
}
