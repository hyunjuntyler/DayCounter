//
//  HapticFeedback.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

class HapticFeedback {
    
    static let shared = HapticFeedback()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
