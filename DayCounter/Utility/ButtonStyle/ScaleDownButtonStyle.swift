//
//  ScaleDownButtonStyle.swift
//  DayCounter
//
//  Created by Hyunjun Kim on 5/2/24.
//

import SwiftUI

struct ScaleDownButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
