//
//  NetworkingManger.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://reddit.com/top.json"

    var isPaginating = false
    
    var after = ""
    var count = 0
    
    private init() {}
    
    
    func fetchPosts(pagination: Bool = false, completion: @escaping (Result<[Post], TRError>) -> Void) {
        if pagination  {
            isPaginating.toggle()
        }
        
        let endpoint = after != "" ? baseURL + "?count=\(count)&after=\(after)" : baseURL
        
        guard let finalURL = URL(string: endpoint) else {
            return completion(.failure(.unableToComplete))
        }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if error != nil {
                return completion(.failure(.invalidResponse))
            }
            
            guard let data = data else { return completion(.failure(.invalidData)) }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(PostTopLevelObject.self, from: data)
                let secondLevelDict = topLevelDictionary.data
                let thirdLevelArray = secondLevelDict.children
                self.after = (secondLevelDict.after)
                self.count += 25
                
                var arrayOfPosts: [Post] = []
                
                for dict in thirdLevelArray {
                    let post = dict.data
                    arrayOfPosts.append(post)
                }
                
                if pagination  {
                    self.isPaginating.toggle()
                }
                return completion(.success(arrayOfPosts))
                
            } catch {
                return completion(.failure(.unableToComplete))
            }
        }.resume()
    }
    
    func fetchThumbnail(post: Post, completion: @escaping (Result<UIImage, TRError>) -> Void) {

        guard let thumbnailURL = URL(string: post.thumbnail) else { return completion(.failure(.unableToComplete))}

        URLSession.shared.dataTask(with: thumbnailURL) { (data, _, error) in
            if error != nil {
                return completion(.failure(.invalidResponse))
            }

            guard let data = data else { return completion(.failure(.invalidData)) }

            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.invalidData))}

            return completion(.success(thumbnail))

        }.resume()
    }
}
