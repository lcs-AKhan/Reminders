//
//  ContentView.swift
//  Shared
//
//  Created by Abdul-CS on 2022-01-20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store: TaskStore
    
    @State private var showingAddTask = false
    
    @State var showingCompletedTasks = true
    
    var body: some View {
        List {
            ForEach(store.tasks) { task in
                
                if showingCompletedTasks {
                    TaskCell(task: task)
                } else {
                    
                    // only show incomplete tasks
                    if task.completed == false {
                        TaskCell(task: task)
                    }
                    
                }
                
            }
            .onDelete(perform: store.deleteItems)
            .onMove(perform: store.moveItems)
        }
        .navigationTitle("Reminders")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .bottomBar) {
                // toggle visibility of tasks
                Button(showingCompletedTasks ? "Hide completed tasks" : "Show completed tasks") {
                    print("Value of showingCompletedTasks was: \(showingCompletedTasks)")
                    showingCompletedTasks.toggle()
                    print("Value of showingCompletedTasks is: \(showingCompletedTasks)")
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTask(store: testStore, showing: $showingAddTask)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
        }
    }
}
