//
//  Medicine.swift
//  You
//
//  Created by Oliver Gilcher on 4/24/25.
//

import Foundation

struct Medicine: Codable {
    let id: String
    let name: String
    let type: String
    let dosage: Int
    let takeTime: Date
    let startDay: Date
    let duration: Int
    let alarm: Bool
    
    init(
        id: String,
        name: String,
        type: String,
        dosage: Int,
        takeTime: Date,
        startDay: Date,
        duration: Int,
        alarm: Bool
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.dosage = dosage
        self.takeTime = takeTime
        self.startDay = startDay
        self.duration = duration
        self.alarm = alarm
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case dosage = "dosage"
        case takeTime = "take_time"
        case startDay = "start_day"
        case duration = "duration"
        case alarm = "alarm"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.dosage = try container.decode(Int.self, forKey: .dosage)
        self.takeTime = try container.decode(Date.self, forKey: .takeTime)
        self.startDay = try container.decode(Date.self, forKey: .startDay)
        self.duration = try container.decode(Int.self, forKey: .duration)
        self.alarm = try container.decode(Bool.self, forKey: .alarm)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.dosage, forKey: .dosage)
        try container.encode(self.takeTime, forKey: .takeTime)
        try container.encode(self.startDay, forKey: .startDay)
        try container.encode(self.duration, forKey: .duration)
        try container.encode(self.alarm, forKey: .alarm)
    }
}
