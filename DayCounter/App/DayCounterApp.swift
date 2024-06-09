//
//  DayCounterApp.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

@main
struct DayCounterApp: App {
    @AppStorage("isMigrated") private var isMigrated = false
    
    init() {
        if !isMigrated {
            migrate()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func migrate() {
        if let data = UserDefaults.standard.data(forKey: "EventItems") {
            UserDefaults.standard.set(data, forKey: "Events")
            UserDefaults.standard.removeObject(forKey: "EventItems")
            isMigrated = true
        }
    }
}
