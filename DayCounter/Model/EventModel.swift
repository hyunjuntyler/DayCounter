//
//  EventModel.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import Foundation

struct Event: Identifiable, Encodable, Decodable {
    var id = UUID()
    var date: Date
    var title: String
    var note: String
    
    init(id: UUID = UUID(), date: Date, title: String, note: String) {
        self.id = id
        self.date = date
        self.title = title
        self.note = note
    }
}


class EventModel: ObservableObject {
    @Published var events: [Event] = []
    
    
    // MARK: Basic Functions
    
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
    
    // MARK: List onDelete, onMove 의 perform: 뒤에 들어가는 함수
    
    func delete(at: IndexSet) {
        events.remove(atOffsets: at)
        saveItems()
    }
    
    func move(from: IndexSet, to: Int) {
        events.move(fromOffsets: from, toOffset: to)
        saveItems()
    }
    
    // MARK: Save, Load items in User Defaults
    
    func saveItems() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(events) {
            UserDefaults.standard.set(encodedData, forKey: "EventItems")
        }
    }
    
    func loadItems() {
        if let savedData = UserDefaults.standard.data(forKey: "EventItems") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Event].self, from: savedData) {
                events = decodedData
            }
        }
    }
    
    init() {
        loadItems()
    }
}