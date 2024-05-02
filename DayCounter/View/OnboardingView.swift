//
//  OnboardingView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var onboarding = true
    
    var body: some View {
        VStack {
            Group {
                Text("Welcome to")
                Text("Day Counter")
                    .foregroundStyle(.tint)
                    .padding(.bottom, 60)
            }
            .font(.system(size: 40))
            .fontWeight(.bold)
            .fontDesign(.rounded)
            
            VStack(alignment: .leading, spacing: 30) {
                onboardingList(icon: "calendar.badge.plus", text: "디데이 리스트 만들기", content: "소중한 날짜를 추가해 주세요")
                onboardingList(icon: "list.dash", text: "리스트 관리하기", content: "편집을 눌러 리스트를 관리해 보세요")
            }
            .padding(.horizontal, 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            StartButton(label: "시작하기") {
                Haptic.impact(style: .soft)
                onboarding = false
            }
            .padding(.bottom, 60)
        }
        .padding(.top, 80)
    }
    
    @ViewBuilder
    func onboardingList(icon: String, text: LocalizedStringKey, content: LocalizedStringKey) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading, spacing: 5) {
                Text(text)
                    .font(.body)
                    .bold()
                Text(content)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
        }
    }
}

#Preview("한국어") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "ko"))
}

#Preview("영어") {
    OnboardingView()
        .environment(\.locale, .init(identifier: "en"))
}
