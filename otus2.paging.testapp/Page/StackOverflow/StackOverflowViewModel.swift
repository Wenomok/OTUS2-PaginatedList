//
//  StackOverflowViewModel.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import UIKit
import SwiftUI

class StackOverflowViewModel: ContentViewModel {
    @Published private(set) var items: [SOQuestion] = []
    
    func loadQuestions(page: Int) {
        self.page = page
        
        if self.page == 1 {
            DispatchQueue.main.async {
                self.items.removeAll()
                self.isReloading = true
                self.isNextPageAvailable = true
            }
        }
        
        NetworkManager.shared.getSOQuestions(byTag: "swiftui", page: page) { response in
            if self.page == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isReloading = false
                }
            }
            
            switch response {
            case .success(let data):
                do {
                    let soResponse = try JSONDecoder().decode(SOResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.isNextPageAvailable = soResponse.hasMore
                        
                        if self.page == 1 {
                            self.items = soResponse.items
                        } else {
                            self.items.append(contentsOf: soResponse.items)
                        }
                    }
                } catch(let error) {
                    DispatchQueue.main.async {
                        self.isNextPageAvailable = false
                    }
                    
                    debugPrint(error)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isNextPageAvailable = false
                }
                debugPrint(error)
            }
        }
    }
}
