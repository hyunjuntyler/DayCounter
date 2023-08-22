//
//  CalculateDay.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import Foundation
import SwiftUI

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
        return "D+\(-days)"
    }
}
