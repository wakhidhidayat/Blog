//
//  ApiCall.swift
//  Blog
//
//  Created by Wahid Hidayat on 03/01/22.
//

import Foundation
import Alamofire

struct ApiCall {
    fileprivate static let baseUrl = "https://jsonplaceholder.typicode.com/"
    static let nonAuthHeaders: HTTPHeaders = [
        "Accept": "application/json"
    ]
}

enum Endpoints {
    case getPosts
    case getUser(id: Int)
    case getComments
    case getAlbums
    case getPhotos
    
    var url: String {
        switch self {
        case .getPosts: return "\(ApiCall.baseUrl)posts"
        case .getUser(let id): return "\(ApiCall.baseUrl)users/\(id)"
        case .getComments: return "\(ApiCall.baseUrl)comments"
        case .getAlbums: return "\(ApiCall.baseUrl)albums"
        case .getPhotos: return "\(ApiCall.baseUrl)photos"
        }
    }
}
