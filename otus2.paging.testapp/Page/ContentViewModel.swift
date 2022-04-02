//
//  ContentViewModel.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 26.03.2022.
//

import UIKit

class ContentViewModel: ObservableObject {
    @Published var isReloading: Bool = false
    @Published var isNextPageAvailable: Bool = true
    
    var page: Int = 1
}
