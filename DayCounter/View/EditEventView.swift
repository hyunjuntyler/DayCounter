//
//  EditEventView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct EditEventView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var eventModel: EventModel
    @State var date: Date
    @State var title: String
    @State var note: String
    @State var id: UUID
    
    @State var alert = false
    @State var openDatePicker = false
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("날짜")
                        Spacer()
                        Button {
                            withAnimation() {
                                openDatePicker.toggle()
                            }
                        } label: {
                            Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                .foregroundStyle(openDatePicker ? .mint : .primary)
                                .padding(5)
                                .padding(.horizontal, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .foregroundStyle(.thinMaterial)
                                )
                        }
                    }
                    if openDatePicker {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                }
                Section {
                    HStack {
                        TextField("제목", text: $title)
                            .onTapGesture {
                                withAnimation() {
                                    openDatePicker = false
                                }
                            }
                        if !title.isEmpty {
                            Image(systemName: "multiply.circle.fill")
                                .font(.callout)
                                .foregroundStyle(Color(.systemGray5))
                                .onTapGesture {
                                    title = ""
                                }
                        }
                    }
                    HStack {
                        TextField("노트", text: $note, axis: .vertical)
                            .onTapGesture {
                                withAnimation() {
                                    openDatePicker = false
                                }
                            }
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
                            let editedItem = Event(id: id, date: date, title: title, note: note)
                            eventModel.deleteItem(item: editedItem)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("디데이 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button {
                        let editedItem = Event(id: id, date: date, title: title, note: note)
                        eventModel.editItem(item: editedItem)
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
