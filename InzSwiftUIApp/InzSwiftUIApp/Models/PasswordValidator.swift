//
//  PasswordValidator.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 28/01/2021.
//

import Foundation
func isValidPassword(_ password: String) -> Bool{
    let passRegex = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
    return passRegex.evaluate(with: password)
}
