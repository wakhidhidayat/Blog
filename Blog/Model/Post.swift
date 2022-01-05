//
//  Post.swift
//  Blog
//
//  Created by Wahid Hidayat on 03/01/22.
//

import Foundation

struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct PostList: Decodable {
    let id: Int
    let title: String
    let body: String
    let user: String
    let company: String
    let userId: Int
}
