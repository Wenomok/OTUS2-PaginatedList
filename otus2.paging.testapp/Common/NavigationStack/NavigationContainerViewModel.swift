//
//  NavigationContainerViewModel.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 02.04.2022.
//

import UIKit
import SwiftUI

class NavigationContainerViewModel: ObservableObject {
    @Published private(set) var currentScreen: Screen?
    private(set) var navigationType: NavigationType = .push
    
    private var screenStack: NavigationStack = NavigationStack() {
        didSet {
            currentScreen = screenStack.top
        }
    }
    
    func push(screenView: AnyView) {
        navigationType = .push
        screenStack.push(screen: Screen(view: screenView))
    }
    
    func pop() {
        navigationType = .pop
        screenStack.pop()
    }
    
    func popToRoot() {
        navigationType = .popToRoot
        screenStack.popToRoot()
    }
}
