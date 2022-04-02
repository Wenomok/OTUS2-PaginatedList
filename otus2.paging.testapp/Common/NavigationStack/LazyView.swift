//
//  LazyView.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 02.04.2022.
//

import SwiftUI
import UIKit

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}
