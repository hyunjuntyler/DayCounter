//
//  ContentView.swift
//  DayCounter
//
//  Created by hyunjun on 2023/08/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var onboarding: Bool = true
    
    init() {
        var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)?
                .withSymbolicTraits(.traitBold) ?? titleFont.fontDescriptor,
            size: titleFont.pointSize
        )
        
        var inlineFont = UIFont.preferredFont(forTextStyle: .body)
        inlineFont = UIFont(
            descriptor:
                inlineFont.fontDescriptor
                .withDesign(.rounded)?
                .withSymbolicTraits(.traitBold) ?? inlineFont.fontDescriptor,
            size: inlineFont.pointSize
        )
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
        UINavigationBar.appearance().titleTextAttributes = [.font: inlineFont]
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemMint
    }
    
    var body: some View {
        EventListView()
            .sheet(isPresented: $onboarding) {
                OnboardingView()
                    .interactiveDismissDisabled()
            }
    }
}

#Preview("한국어") {
    ContentView()
        .environment(\.locale, .init(identifier: "ko"))
}

#Preview("영어") {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}
