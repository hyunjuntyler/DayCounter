//
//  MainCardView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct EventCard: View {
    @ObservedObject var eventModel: EventModel
    @State private var editEventView = false
    var event: Event
    
    var body: some View {
        
        let dayCount = calculateDays(to: event.date)
        let dayCountString = formatDayCount(dayCount)
        
        Button {
            Haptic.impact(style: .soft)
            editEventView = true
        } label: {
            HStack {
                Text("\(dayCountString)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.mint)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .foregroundColor(Color(.systemGray6))
                    )
                    .padding(.leading, -5)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text("\(event.date.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundStyle(Color(.systemGray2))
                    Text("\(event.title)")
                        .font(.tossFaceMedium)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
                .padding(.vertical, 5)
            }
        }
        .buttonStyle(StartButtonStyle())
        .sheet(isPresented: $editEventView) {
            EditEventView(eventModel: eventModel, date: event.date, title: event.title, note: event.note, id: event.id)
        }
    }
        
    private func calculateDays(to dateCount: Date) -> Int {
        let calendar = Calendar.current
        
        let start = calendar.startOfDay(for: Date())
        let end = calendar.startOfDay(for: dateCount)
        
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        return components.day ?? 0
    }
        
    private func formatDayCount(_ days: Int) -> String {
        if days == 0 {
            return "D-Day"
        } else if days > 0 {
            return "D-\(days)"
        } else {
            return "D+\(-days + 1)"
        }
    }
}

#Preview("한국어") {
    List {
        EventCard(eventModel: EventModel(), event: Event(date: Date(), title: "테스트", note: "테스트"))
    }
    .environment(\.locale, .init(identifier: "ko"))
}

#Preview("영어") {
    List {
        EventCard(eventModel: EventModel(), event: Event(date: Date(), title: "Test", note: "Test"))
    }
    .environment(\.locale, .init(identifier: "en"))
}
