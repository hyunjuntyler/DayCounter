//
//  OnboardingList.swift
//  DayCounter
//
//  Created by Hyunjun Kim on 5/2/24.
//

import SwiftUI

struct OnboardingList: View {
    var icon: String
    var text: LocalizedStringKey
    var content: LocalizedStringKey
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title)
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

#Preview {
    OnboardingList(icon: "person.crop.circle", text: "preview", content: "preview")
}
