//
//  DayCounterApp.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

@main
struct DayCounterApp: App {
    private let migration = Migration()
    
    init() {
        migration.execute()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private class Migration {
    func execute() {
        if let data = UserDefaults.standard.data(forKey: "EventItems") {
            UserDefaults.standard.set(data, forKey: "Events")
        }
    }
}
