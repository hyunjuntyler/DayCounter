//
//  AddView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var eventModel: EventModel
    @State var date = Date()
    @State var title = ""
    @State var note = ""
    
    @State private var openDatePicker = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("날짜")
                        Button {
                            withAnimation(.easeInOut) {
                                openDatePicker.toggle()
                            }
                            HapticFeedback.shared.impact(style: .soft)
                        } label: {
                            Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                .foregroundStyle(openDatePicker ? .mint : .primary)
                                .padding(6)
                                .padding(.horizontal, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .foregroundStyle(.thinMaterial)
                                )
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, -5)
                    }
                    if openDatePicker {
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                    }
                }
                Section {
                    HStack {
                        TextField("제목", text: $title)
                        if !title.isEmpty {
                            Image(systemName: "multiply.circle.fill")
                                .font(.callout)
                                .foregroundStyle(Color(.systemGray5))
                                .onTapGesture {
                                    title = ""
                                }
                        }
                    }
                    HStack(alignment: .top) {
                        TextField("노트", text: $note, axis: .vertical)
                        if !note.isEmpty {
                            Image(systemName: "multiply.circle.fill")
                                .font(.callout)
                                .foregroundStyle(Color(.systemGray5))
                                .onTapGesture {
                                    note = ""
                                }
                        }
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        openDatePicker = false
                    }
                }
            }
            .navigationTitle("디데이 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let item = Event(date: date, title: title, note: note)
                        eventModel.addItem(item: item)
                        dismiss()
                    } label: {
                        Text("저장")
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview("한국어") {
    AddEventView(eventModel: EventModel())
        .environment(\.locale, .init(identifier: "ko"))
}

#Preview("영어") {
    AddEventView(eventModel: EventModel())
        .environment(\.locale, .init(identifier: "en"))
}
