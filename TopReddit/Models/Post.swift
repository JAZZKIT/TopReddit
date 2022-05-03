//
//  Post.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import Foundation

import Foundation

struct PostTopLevelObject: Codable {
    let data: PostSecondLevelObject
}

struct PostSecondLevelObject: Codable {
    let children: [PostThirdLevelObject]
}

struct PostThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let title: String
    let author: String
    let num_comments: Int
    let thumbnail: String
    let created_utc: Int
    let url_overridden_by_dest: String
}
