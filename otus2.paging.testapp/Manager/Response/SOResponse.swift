//
//  SOQuestion.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 27.03.2022.
//

import UIKit

struct SOResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
    }
    
    var items: [SOQuestion]
    var hasMore: Bool
}

struct SOQuestion: Identifiable, Decodable {
    var id: String { UUID().uuidString }
    
    enum CodingKeys: String, CodingKey {
        case title
        case questionId = "question_id"
        case viewCount = "view_count"
    }
    
    var title: String
    var questionId: Int
    var viewCount: Int
}
