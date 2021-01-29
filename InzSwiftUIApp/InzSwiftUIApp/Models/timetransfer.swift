//
//  timetransfer.swift
//  InzSwiftUIApp
//
//  Created by Przemysław Woźny on 28/01/2021.
//

import Foundation

func getDateFromTimeStamp(timeStamp : Double) -> String {
    let time = TimeInterval(timeStamp) / 1000
    let date = Date(timeIntervalSince1970: time)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
    dateFormatter.timeZone = .current
    let localDate = dateFormatter.string(from: date)
    return localDate
}
