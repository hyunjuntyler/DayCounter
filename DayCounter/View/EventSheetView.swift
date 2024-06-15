//
//  AddView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct EventSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var eventModel: EventModel
    
    @State private var date = Date()
    @State private var title = ""
    @State private var note = ""
    
    @State private var alert = false
    @State private var openDatePicker = false
    
    var event: Event?
    
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
                            HapticManager.impact(style: .soft)
                        } label: {
                            Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                .foregroundStyle(openDatePicker ? .mint : .primary)
                                .padding(6)
                                .padding(.horizontal, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .foregroundStyle(.regularMaterial)
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
                            .font(.tossFaceSmall)
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
                            .font(.tossFaceSmall)
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
                
                if let event = event {
                    Section {
                        Button(role: .destructive) {
                            alert.toggle()
                        } label: {
                            HStack {
                                Spacer()
                                Text("삭제")
                                Spacer()
                            }
                        }
                        .alert("정말 삭제하시겠어요?", isPresented: $alert) {
                            Button("삭제", role: .destructive) {
                                eventModel.deleteEvent(event.id)
                                HapticManager.impact(style: .rigid)
                                dismiss()
                            }
                        }
                    }
                }
            }
            .navigationTitle(event == nil ? "디데이 추가" : "디데이 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if let event = event {
                            let item = Event(id: event.id, date: date, title: title, note: note)
                            eventModel.editEvent(item)
                        } else {
                            let item = Event(date: date, title: title, note: note)
                            eventModel.addEvent(item)
                        }
                        HapticManager.notification(type: .success)
                        dismiss()
                    } label: {
                        Text("저장")
                            .bold()
                    }
                }
            }
            .onAppear {
                if let event = event {
                    date = event.date
                    title = event.title
                    note = event.note
                }
            }
        }
    }
}

#Preview("한국어") {
    EventSheetView(eventModel: EventModel())
        .environment(\.locale, .init(identifier: "ko"))
}

#Preview("영어") {
    EventSheetView(eventModel: EventModel())
        .environment(\.locale, .init(identifier: "en"))
}
