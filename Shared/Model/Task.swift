//
//  Task.swift
//  Reminders (iOS)
//
//  Created by Abdul-CS on 2022-01-20.
//

import Foundation
import SwiftUI

enum TaskCodingKeys: CodingKey {
    case description
    case priority
    case completed
}

class Task: Identifiable, ObservableObject, Codable {
    
    // MARK: Stored properties
    var id = UUID()
    var description: String
    var priority: TaskPriority
    @Published var completed: Bool
    
    // MARK: Initializers
    internal init(id: UUID = UUID(), description: String, priority: TaskPriority, completed: Bool) {
        self.id = id
        self.description = description
        self.priority = priority
        self.completed = completed
    }
    
    // MARK: Functions
    func encode(to encoder: Encoder) throws {
        
        // Create a container that will be used to write an instance of the Task type to JSON
        var container = encoder.container(keyedBy: TaskCodingKeys.self)
        
        //Everything encoded into string types
        try container.encode(description, forKey: .description)
        try container.encode(priority, forKey: .priority)
        try container.encode(completed, forKey: .completed)
        
    }
    
    // Provide details for how to decode from JSON into an instance of this data type
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: TaskCodingKeys.self)
        
        self.description = try container.decode(String.self, forKey: .description)
        self.priority = try container.decode(TaskPriority.self, forKey: .priority)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
}

let testData = [
    Task(description: "Grow long hair", priority: .high, completed: true),
    Task(description: "Get modelling contract", priority: .medium, completed: false),
    Task(description: "Reture from teaching", priority: .low, completed: false),
]
