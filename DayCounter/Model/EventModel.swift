//
//  EventModel.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var title: String
    var note: String
}

class EventModel: ObservableObject {
    @Published var events: [Event] = []
    
    init() {
        loadEvents()
    }
        
    func addEvent(_ event: Event) {
        events.append(event)
        saveEvents()
    }
    
    func editEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            print("Item Index: \(index)")
            events[index] = event
            saveEvents()
        }
    }
    
    func deleteEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events.remove(at: index)
            saveEvents()
        }
    }
        
    func delete(at: IndexSet) {
        withAnimation {
            events.remove(atOffsets: at)
            saveEvents()
        }
    }
    
    func move(from: IndexSet, to: Int) {
        withAnimation {
            events.move(fromOffsets: from, toOffset: to)
            saveEvents()
        }
    }
}

// MARK: - Persistence

extension EventModel {
    private func saveEvents() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(events) {
            UserDefaults.standard.set(encodedData, forKey: "Events")
        }
    }
    
    private func loadEvents() {
        if let savedData = UserDefaults.standard.data(forKey: "Events") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Event].self, from: savedData) {
                events = decodedData
            }
        }
    }
}
