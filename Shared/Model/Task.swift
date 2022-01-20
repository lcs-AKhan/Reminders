//
//  Task.swift
//  Reminders (iOS)
//
//  Created by Abdul-CS on 2022-01-20.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var description: String
    var priority: TaskPriority
    var completed: Bool
}

let testData = [
    Task(description: "Grow long hair", priority: .high, completed: true)
    Task(description: "Get modelling contract", priority: .medium, completed: false)
    Task(description: "Reture from teaching", priority: .low, completed: false)
]
