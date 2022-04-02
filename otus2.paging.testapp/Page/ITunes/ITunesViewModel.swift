//
//  ITunesViewModel.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import UIKit
import SwiftUI

class ITunesViewModel: ContentViewModel {
    @Published private(set) var itunesItems: [MediaItem] = []
    
    private(set) var isFirstLoading: Bool = true
    
    func loadITunesSongs(page: Int, isRefresh: Bool = false) {
        if isFirstLoading {
            isFirstLoading = false
        }
        self.page = page
        
        if isRefresh {
            DispatchQueue.main.async {
                self.itunesItems.removeAll()
                self.isReloading = true
                self.isNextPageAvailable = true
            }
        }
        
        NetworkManager.shared.getSongs(byArtist: "Black eyed peas", page: page) { response in
            if isRefresh {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isReloading = false
                }
            }
            
            switch response {
            case .success(let data):
                do {
                    let itunesResponse = try JSONDecoder().decode(ITunesResponse.self, from: data)
                    DispatchQueue.main.async {
                        if self.page == 1 {
                            self.itunesItems = itunesResponse.results
                        } else {
                            self.itunesItems.append(contentsOf: itunesResponse.results)
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
