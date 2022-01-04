//
//  User.swift
//  Blog
//
//  Created by Wahid Hidayat on 03/01/22.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let company: Company
}

struct Company: Decodable {
    let name: String
}
