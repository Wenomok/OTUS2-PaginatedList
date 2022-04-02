//
//  NavigationContainerView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 02.04.2022.
//

import UIKit
import SwiftUI

struct NavigationContainerView<Content: View>: View {
    @ObservedObject private var viewModel: NavigationContainerViewModel = .init()
    
    private let content: Content
    private let animation: Animation = .easeOut(duration: 0.3)
    private let transition: (push: AnyTransition, pop: AnyTransition)
    
    init(transition: Transition, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        
        switch transition {
        case .none:
            self.transition = (.identity, .identity)
        case .custom(let anyTransition):
            self.transition = (anyTransition, anyTransition)
        }
    }
    
    var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                content.environmentObject(viewModel)
                    //.animation(.easeOut, value: 0.3)
                    .animation(animation)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            } else {
                viewModel.currentScreen?.view.environmentObject(viewModel)
//                    .animation(.easeOut, value: 0.3)
                    .animation(animation)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            }
        }
    }
}
