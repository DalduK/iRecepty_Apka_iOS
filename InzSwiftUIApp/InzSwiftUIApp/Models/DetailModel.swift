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
    var createdDate: String?
    var exparition: String
    var status: String
    var medications: [String: Int]
    var description: String?
    var shortDescription: String?

}
