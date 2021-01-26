//
//  HomeData.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 26/01/2021.
//

import Foundation


struct HomeData:  Codable {
    var idRecepty: Int
    var data: String
    var nazwa: String
    var lekarz: String
    var wykorzystana: Bool    
}
