//
//  Important.swift
//  Reminders
//
//  Created by Abdul-CS on 2022-01-26.
//

import SwiftUI

struct Important: View {
    
    @ObservedObject var store: TaskStore
    
    var body: some View {
        VStack {
            List {
                ForEach(store.tasks) { task in
                    if task.priority == .high {
                        TaskCell(task: task, triggerListUpdate: .constant(true))
                    }
                }
            }
        }
        .navigationTitle("Important")
    }
}

struct Important_Previews: PreviewProvider {
    static var previews: some View {
        Important(store: testStore)
    }
}
