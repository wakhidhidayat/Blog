//
//  Comment.swift
//  Blog
//
//  Created by Wahid Hidayat on 04/01/22.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let name: String
    let body: String
    let postId: Int
}
