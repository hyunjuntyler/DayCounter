//
//  StartButton.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct StartButton: View {
    var label: LocalizedStringKey
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .bold()
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .foregroundColor(.accentColor)
                )
        }
        .buttonStyle(StartButtonStyle())
        .padding(.horizontal, 25)
    }
}

struct StartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

#Preview {
    StartButton(label: "시작하기") {
        // action
    }
}
