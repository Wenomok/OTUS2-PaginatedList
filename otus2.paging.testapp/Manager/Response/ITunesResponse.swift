//
//  ITunesResponse.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 26.03.2022.
//

import UIKit

struct ITunesResponse: Identifiable, Decodable {
    var results: [MediaItem]
    
    var id: String { UUID().uuidString }
}

struct MediaItem: Identifiable, Decodable {
    var artistName: String
    var collectionName: String
    var trackName: String
    var trackPrice: CGFloat
    
    var id: String { "\(artistName)_\(trackName)_\(collectionName)" }
}
