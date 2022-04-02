//
//  ITunesViewModel.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import UIKit
import SwiftUI

class ITunesViewModel: ObservableObject {
    @Published var isReloading: Bool = true
    
    @Published var itunesItems: [MediaItem] = []
    
    var page: Int = 1
    
    @Published var isNextPageAvailable: Bool = true
    
    func loadITunesSongs(page: Int) {
        self.page = page
        
        if self.page == 1 {
            DispatchQueue.main.async {
                self.isReloading = true
                self.isNextPageAvailable = true
            }
        }
        
        NetworkManager.shared.getSongs(byArtist: "Black eyed peas", page: page) { response in
            if self.page == 1 {
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
