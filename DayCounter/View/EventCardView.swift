//
//  MainCardView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct EventCardView: View {
    @ObservedObject var eventModel: EventModel
    @State private var editEventView = false
    var event: Event
    
    var body: some View {
        Button {
            HapticManager.impact(style: .soft)
            editEventView = true
        } label: {
            HStack {
                Text("\(event.date.getDday)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.mint)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundStyle(.regularMaterial)
                    )
                    .padding(.leading, -5)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text("\(event.date.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text("\(event.title)")
                        .font(.tossFaceMedium)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
                .padding(.vertical, 5)
            }
        }
        .buttonStyle(ScaleDownButtonStyle())
        .sheet(isPresented: $editEventView) {
            EventSheetView(eventModel: eventModel, event: event)
        }
    }
}

#Preview("한국어") {
    List {
        EventCardView(eventModel: EventModel(), event: Event(date: Date(), title: "테스트", note: "테스트"))
    }
    .environment(\.locale, .init(identifier: "ko"))
}

#Preview("영어") {
    List {
        EventCardView(eventModel: EventModel(), event: Event(date: Date(), title: "Test", note: "Test"))
    }
    .environment(\.locale, .init(identifier: "en"))
}
