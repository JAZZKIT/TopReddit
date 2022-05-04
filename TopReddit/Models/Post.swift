//
//  Post.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import Foundation

struct PostTopLevelObject: Codable {
    let data: PostSecondLevelObject
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct PostSecondLevelObject: Codable {
    let after: String
    let children: [PostThirdLevelObject]
    
    enum CodingKeys: String, CodingKey {
        case after = "after"
        case children = "children"
    }
}

struct PostThirdLevelObject: Codable {
    let data: Post
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct Post: Codable {
    let title: String
    let author: String
    let num_comments: Int
    let thumbnail: String
    let created_utc: Int
    let url_overridden_by_dest: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case num_comments = "num_comments"
        case thumbnail = "thumbnail"
        case created_utc = "created_utc"
        case url_overridden_by_dest = "url_overridden_by_dest"
    }
}
