//
//  MainCardView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct MainCardView: View {
    
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
                            .fill(.ultraThinMaterial)
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
//        HStack {
//            Text("\(dayCountString)")
//                .font(.title)
//                .bold()
//                .fontDesign(.rounded)
//                .foregroundStyle(.mint)
//                .padding(20)
//                .background(
//                    RoundedRectangle(cornerRadius: 12, style: .continuous)
//                        .fill(.ultraThinMaterial)
//                )
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text("\(event.date.formatted(date: .abbreviated, time: .omitted))")
//                    .font(.caption)
//                    .foregroundStyle(Color(.systemGray2))
//                Spacer()
//                Text("\(event.title)")
//                    .font(.title3)
//            }
//            .padding(.vertical, 20)
//        }
//        .onTapGesture {
//            editEventView = true
//        }
        .sheet(isPresented: $editEventView) {
            EditEventView(eventModel: eventModel, date: event.date, title: event.title, note: event.note, id: event.id)
        }
    }
}

struct MainCardView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MainCardView(event: Event(date: Date(), title: "테스트", note: "테스트입니다"), eventModel: EventModel())
        }
    }
}
