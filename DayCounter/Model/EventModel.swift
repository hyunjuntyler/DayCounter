//
//  EventModel.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Encodable, Decodable {
    var id = UUID()
    var date: Date
    var title: String
    var note: String
}

class EventModel: ObservableObject {
    @Published var events: [Event] = []
    
    init() {
        loadItems()
    }
        
    func addItem(item: Event) {
        events.append(item)
        saveItems()
    }
    
    func editItem(item: Event) {
        if let index = events.firstIndex(where: { $0.id == item.id }) {
            print("Item Index: \(index)")
            events[index] = item
            saveItems()
        }
    }
    
    func deleteItem(item: Event) {
        if let index = events.firstIndex(where: { $0.id == item.id }) {
            events.remove(at: index)
            saveItems()
        }
    }
        
    func delete(at: IndexSet) {
        withAnimation {
            events.remove(atOffsets: at)
            saveItems()
        }
    }
    
    func move(from: IndexSet, to: Int) {
        withAnimation {
            events.move(fromOffsets: from, toOffset: to)
            saveItems()
        }
    }
}

// MARK: - Persistence

extension EventModel {
    private func saveItems() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(events) {
            UserDefaults.standard.set(encodedData, forKey: "EventItems")
        }
    }
    
    private func loadItems() {
        if let savedData = UserDefaults.standard.data(forKey: "EventItems") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Event].self, from: savedData) {
                events = decodedData
            }
        }
    }
}
