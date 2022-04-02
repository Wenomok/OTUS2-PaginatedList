//
//  NavigationStack.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 02.04.2022.
//

import UIKit

struct NavigationStack {
    private var screens: [Screen] = []
    
    var top: Screen? {
        return screens.last
    }
    
    mutating func push(screen: Screen) {
        screens.append(screen)
    }
    
    mutating func pop() {
        _ = screens.removeLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}
