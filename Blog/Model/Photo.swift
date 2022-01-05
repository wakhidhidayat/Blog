//
//  Photo.swift
//  Blog
//
//  Created by Wahid Hidayat on 05/01/22.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    let albumId: Int
}
