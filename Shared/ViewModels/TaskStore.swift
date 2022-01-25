//
//  TaskStore.swift
//  Reminders (iOS)
//
//  Created by Abdul-CS on 2022-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    
    // MARK: Stored properties
    @Published var tasks: [Task]
    
    // MARK: Initializers
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    // MARK: Functions
    func deleteItems(at offsets: IndexSet) {
        // "offsets" cocntains a set of items selected for deletion
        // The set is then passed to the built in "remove" method on
        // the "tasks" array which handles removal from the array
        tasks.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
}

let testStore = TaskStore(tasks: testData)