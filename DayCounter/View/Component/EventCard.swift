//
//  MainCardView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct EventCard: View {
    
    @State private var editEventView = false
    var event: Event
    @ObservedObject var eventModel: EventModel
    
    var body: some View {
        
        let dayCount = calculateDays(to: event.date)
        let dayCountString = formatDayCount(dayCount)
        
        Button {
            HapticFeedback.shared.impact(style: .soft)
            editEventView = true
        } label: {
            HStack {
                Text("\(dayCountString)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.mint)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(.systemGray6))
                    )
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(event.date.formatted(date: .abbreviated, time: .omitted))")
                        .font(.footnote)
                        .foregroundStyle(Color(.systemGray2))
                    Spacer()
                    Text("\(event.title)")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 20)
            }
        }
        .buttonStyle(CustomButtonStyle())
        .sheet(isPresented: $editEventView) {
            EditEventView(eventModel: eventModel, date: event.date, title: event.title, note: event.note, id: event.id)
        }
    }
    
    /// 디데이 계산 함수

    func calculateDays(to dateCount: Date) -> Int {
        let calendar = Calendar.current

        let start = calendar.startOfDay(for: Date())
        let end = calendar.startOfDay(for: dateCount)

        let components = calendar.dateComponents([.day], from: start, to: end)

        return components.day ?? 0
    }

    /// 디데이에 따른 표시 설정

    func formatDayCount(_ days: Int) -> String {
        if days == 0 {
            return "D-Day"
        } else if days > 0 {
            return "D-\(days)"
        } else {
            return "D+\(-days + 1)"
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        List {
            EventCard(event: Event(date: Date(), title: "테스트", note: "테스트입니다"), eventModel: EventModel())
        }
    }
}
