//
//  DetailModel.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 27/01/2021.
//

import Foundation


struct PrescriData:  Hashable, Codable {
    var number: String?
    var pesel: String?
    var createdDate: String
    var expiration: String?
    var status: String?
    var medications: [Medications]
    var description: String?
    var shortDescription: String?

}

struct Medications: Hashable, Codable{
    var name:String
    var amount:Int
    var amountLeft:Int
    var active: Bool
}
