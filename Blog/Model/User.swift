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
    let email: String
    let address: Address
    let company: Company
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct Company: Decodable {
    let name: String
}
