//
//  HomeData.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 26/01/2021.
//

import Foundation


struct HomeData: Hashable, Codable {
    var number: String
    var pesel: String?
    var description: String
    var status: String
    var doctor: String
    var creationDate: String
}
