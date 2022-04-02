//
//  Screen.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 02.04.2022.
//

import UIKit
import SwiftUI

struct Screen: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let view: AnyView
    
    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        return lhs.id == rhs.id
    }
}
