//
//  Time.swift
//  You
//
//  Created by Oliver Gilcher on 4/26/25.
//

import Foundation

func hourTime(hour: Int, minute: Int) -> Date {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current // Or use a specific timezone if you want
    
    var components = calendar.dateComponents([.year, .month, .day], from: Date())
    components.hour = hour
    components.minute = minute
    
    return calendar.date(from: components) ?? Date()
}
