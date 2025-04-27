//
//  Task.swift
//  You
//
//  Created by Oliver Gilcher on 4/26/25.
//

import Foundation
import FirebaseFirestore

enum Status: String, Codable {
    case todo, inprogress, complete
}

enum Priority: String, Codable {
    case urgent, high, normal, low
}

struct Task: Codable {
    let id: String
    let group: String
    let title: String
    let description: String
    let startDate: Timestamp
    let dueDate: Timestamp
    let status: Status
    let priority: Priority
    let steps: [Step]
    
    init (
        id: String,
        group: String,
        title: String,
        description: String,
        startDate: Timestamp,
        dueDate: Timestamp,
        status: Status,
        priority: Priority,
        steps: [Step]
    ) {
        self.id = id
        self.group = group
        self.title = title
        self.description = description
        self.startDate = startDate
        self.dueDate = dueDate
        self.status = status
        self.priority = priority
        self.steps = steps
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case group = "group"
        case title = "title"
        case description = "description"
        case startDate = "start_date"
        case dueDate = "due_date"
        case status = "status"
        case priority = "priority"
        case steps = "steps"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.group = try container.decode(String.self, forKey: .group)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.startDate = try container.decode(Timestamp.self, forKey: .startDate)
        self.dueDate = try container.decode(Timestamp.self, forKey: .dueDate)
        self.status = try container.decode(Status.self, forKey: .status)
        self.priority = try container.decode(Priority.self, forKey: .priority)
        self.steps = try container.decode([Step].self, forKey: .steps)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.group, forKey: .group)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.startDate, forKey: .startDate)
        try container.encode(self.dueDate, forKey: .dueDate)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.priority, forKey: .priority)
        try container.encode(self.steps, forKey: .steps)
    }
}

struct Step: Codable {
    let id: String
    let title: String
    let description: String
    let startDate: Timestamp
    let dueDate: Timestamp
    let status: Status
    let priority: Priority
    
    init(
        id: String,
        title: String,
        description: String,
        startDate: Timestamp,
        dueDate: Timestamp,
        status: Status,
        priority: Priority
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.startDate = startDate
        self.dueDate = dueDate
        self.status = status
        self.priority = priority
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case startDate = "start_date"
        case dueDate = "due_date"
        case status = "status"
        case priority = "priority"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.startDate = try container.decode(Timestamp.self, forKey: .startDate)
        self.dueDate = try container.decode(Timestamp.self, forKey: .dueDate)
        self.status = try container.decode(Status.self, forKey: .status)
        self.priority = try container.decode(Priority.self, forKey: .priority)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.startDate, forKey: .startDate)
        try container.encodeIfPresent(self.dueDate, forKey: .dueDate)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.priority, forKey: .priority)
    }
}
