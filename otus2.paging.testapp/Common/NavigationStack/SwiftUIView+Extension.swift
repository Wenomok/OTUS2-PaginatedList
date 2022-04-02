//
//  SwiftUIView+Extension.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 02.04.2022.
//

import UIKit
import SwiftUI

extension View {
    func toAnyView() -> AnyView {
        return AnyView(self)
    }
}
