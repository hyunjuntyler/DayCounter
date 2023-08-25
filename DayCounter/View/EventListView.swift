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
            dayCounterList // List View 따로 빼놓음
                .navigationTitle("Day Counter")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .disabled(eventModel.events.isEmpty)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addEventView = true
                            HapticFeedback.shared.impact(style: .soft)
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
    
    @ViewBuilder
    var dayCounterList: some View {
        List {
            Section {
                ForEach(eventModel.events) { item in
                    EventCard(event: item, eventModel: eventModel)
                }
                .onDelete(perform: eventModel.delete)
                .onMove(perform: eventModel.move)
            }
            Section {
                if eventModel.events.isEmpty {
                    VStack(spacing: 5) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.title2)
                            .foregroundStyle(.mint, .gray)
                        Text("특별한 날을 추가해주세요")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        HapticFeedback.shared.impact(style: .soft)
                        addEventView = true
                    }
                    .padding(10)
                }
            }
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
