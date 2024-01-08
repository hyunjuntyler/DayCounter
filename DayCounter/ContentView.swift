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
        var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle) // the default large title font
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)? // make rounded
                .withSymbolicTraits(.traitBold) // make bold
            ??
            titleFont.fontDescriptor, // return the normal title if customization failed
            size: titleFont.pointSize
        )
        var inlineFont = UIFont.preferredFont(forTextStyle: .body) // the default large body
        inlineFont = UIFont(
            descriptor:
                inlineFont.fontDescriptor
                .withDesign(.rounded)? // make rounded
                .withSymbolicTraits(.traitBold) // make bold
            ??
            inlineFont.fontDescriptor, // return the normal title if customization failed
            size: inlineFont.pointSize
        )
        
        // set the rounded font
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
