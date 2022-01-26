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
    
    @State var listShouldUpdate = false
    
    @State private var selectedPriorityForVisibleTasks: VisibleTaskPriority = .all
    
    var body: some View {
        
        let _ = print("listShouldUpdate has been toggled. Current value is \(listShouldUpdate)")

        VStack {
            
            Text("Filter by...")
                .font(Font.caption.smallCaps())
                .foregroundColor(.secondary)
            
            Picker("Priority", selection: $selectedPriorityForVisibleTasks) {
                Text(VisibleTaskPriority.all.rawValue)
                    .tag(VisibleTaskPriority.all)
                Text(VisibleTaskPriority.low.rawValue)
                    .tag(VisibleTaskPriority.low)
                Text(VisibleTaskPriority.medium.rawValue)
                    .tag(VisibleTaskPriority.medium)
                Text(VisibleTaskPriority.high.rawValue)
                    .tag(VisibleTaskPriority.high)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            List {
                ForEach(store.tasks) { task in
                    
                    if showingCompletedTasks {
                        
                        if selectedPriorityForVisibleTasks == .all {
                            TaskCell(task: task, triggerListUpdate: .constant(true))
                        } else {
                            if task.priority.rawValue == selectedPriorityForVisibleTasks.rawValue {
                                TaskCell(task: task, triggerListUpdate: .constant(true))
                            }
                        }
                        
                    } else {
                        
                        // only show incomplete tasks
                        if task.completed == false {
                            
                            if selectedPriorityForVisibleTasks == .all {
                                TaskCell(task: task, triggerListUpdate: $listShouldUpdate)
                            }
                        }
                        
                    }
                    
                }
                .onDelete(perform: store.deleteItems)
                .onMove(perform: store.moveItems)
            }

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
