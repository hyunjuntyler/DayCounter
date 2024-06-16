//
//  DateExtension.swift
//  DayCounter
//
//  Created by hyunjun on 6/16/24.
//

import Foundation

extension Date {
    var getDday: String {
        let calendar = Calendar.current
        
        let start = calendar.startOfDay(for: Date())
        let end = calendar.startOfDay(for: self)
        
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        guard let day = components.day else { return "Error" }
        
        if day >= 0 {
            return day == 0 ? "D-Day" : "D-\(day)"
        } else {
            return "D+\(-day + 1)"
        }
    }
}
