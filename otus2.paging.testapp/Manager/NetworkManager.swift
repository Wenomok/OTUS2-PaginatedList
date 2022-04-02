//
//  NetworkManager.swift
//  otus2.paging.testapp
//
//  Created by Vladislav Ivshin on 26.03.2022.
//

import UIKit

enum Response {
    case success(data: Data)
    case failure(error: Error)
}

typealias OnComplete = (Response) -> Void

class NetworkManager: NSObject {
    static let shared: NetworkManager = .init()
    
    private let urlSession: URLSession = .shared
    private let itunesHost: String = "https://itunes.apple.com/search"
    private let soHost: String = "https://api.stackexchange.com/2.3/search"
    private let page: Int = 1
    
    func getSongs(byArtist artistName: String, page: Int, completion: @escaping OnComplete) {
        var urlComponents = URLComponents.init(string: itunesHost)
        urlComponents?.queryItems = [
            URLQueryItem.init(name: "media", value: "music"),
            URLQueryItem.init(name: "term", value: artistName.urlEncoded()),
            URLQueryItem.init(name: "limit", value: "15"),
            URLQueryItem.init(name: "lang", value: "ru_ru"),
            URLQueryItem.init(name: "country", value: "RU"),
            URLQueryItem.init(name: "offset", value: "\(page * 15)")
        ]
        
        dataTask(url: urlComponents?.url, completion: completion)
    }
    
    func getSOQuestions(byTag tag: String, page: Int, completion: @escaping OnComplete) {
        var urlComponents = URLComponents.init(string: soHost)
        urlComponents?.queryItems = [
            URLQueryItem.init(name: "order", value: "desc"),
            URLQueryItem.init(name: "sort", value: "activity"),
            URLQueryItem.init(name: "site", value: "stackoverflow"),
            URLQueryItem.init(name: "tagged", value: tag.urlEncoded()),
            URLQueryItem.init(name: "page", value: "\(page)"),
            URLQueryItem.init(name: "pageSize", value: "15"),
        ]
        
        dataTask(url: urlComponents?.url, completion: completion)
    }
    
    private func dataTask(url: URL?, completion: @escaping OnComplete) {
        guard let url = url else {
            completion(.failure(error: NSError.init(domain: "", code: 6)))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let response = response {
                debugPrint(response)
            }
            
            if let error = error {
                completion(.failure(error: error))
                return
            } else {
                guard let data = data else {
                    completion(.failure(error: NSError.init(domain: "", code: 7)))
                    return
                }
                if let str = String.init(data: data, encoding: .utf8) {
                    debugPrint(str)
                }
                
                completion(.success(data: data))
            }
        }.resume()
    }
}
