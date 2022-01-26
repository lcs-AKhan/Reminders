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
        
        let filename = getDocumentsDirectory().appendingPathComponent(savedTasksLabel)
        print(filename)
        
        
        // Attempt to load from the JSON in the stored/persisted file
        do {
            let data = try Data(contentsOf: filename)
            
            print(String(data: data, encoding: .utf8)!)
            
            self.tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print(error.localizedDescription)
            
            self.tasks = tasks
        }
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
    
    // Persist the list of tasks
    func persistTasks() {
        
        // Get a URL that points to the saved JSON data containing our list of tasks
        let filename = getDocumentsDirectory().appendingPathComponent(savedTasksLabel)
        
        // Try to encode into our people array to JSON
        do {
            let encoder = JSONEncoder()
            
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(self.tasks)
            
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            print("Saved data to documents directory successfully")
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

let testStore = TaskStore(tasks: testData)
