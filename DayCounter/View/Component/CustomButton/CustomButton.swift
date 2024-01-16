//
//  CustomButton.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct CustomButton: View {
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
        .buttonStyle(CustomButtonStyle())
        .padding(.horizontal, 25)
    }
}

#Preview {
    CustomButton(label: "시작하기") {
        // action
    }
}
