//
//  Data.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 04/12/2020.
//

import SwiftUI
import CoreLocation

let cardsData: [Cards] = load("cardData.json")

struct Cards: Hashable, Codable, Identifiable {
    var id: Int
    var image: String
    var data: String
    var recepta: String
    var lekarz: String
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch  {
        fatalError("Couldn't find \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch  {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
