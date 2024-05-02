//
//  MainView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct EventListView: View {
    @ObservedObject var eventModel = EventModel()
    @State private var addEventView = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(eventModel.events) { item in
                        EventCard(eventModel: eventModel, event: item)
                    }
                    .onDelete(perform: eventModel.delete)
                    .onMove(perform: eventModel.move)
                }
                
                if eventModel.events.isEmpty {
                    Section {
                        VStack(spacing: 5) {
                            Image(systemName: "calendar.badge.plus")
                                .font(.title2)
                                .foregroundStyle(.mint, .gray)
                            Text("특별한 날을 추가해 주세요")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            Haptic.impact(style: .soft)
                            addEventView = true
                        }
                        .padding(10)
                    }
                }
            }
            .navigationTitle("Day Counter")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .disabled(eventModel.events.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addEventView = true
                        Haptic.impact(style: .soft)
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .sheet(isPresented: $addEventView) {
            AddEventView(eventModel: eventModel)
        }
    }
}

#Preview("한국어") {
    EventListView()
        .environment(\.locale, .init(identifier: "ko"))
}

#Preview("영어") {
    EventListView()
        .environment(\.locale, .init(identifier: "en"))
}
