//
//  NetworkService.swift
//  Blog
//
//  Created by Wahid Hidayat on 03/01/22.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        AF.request(Endpoints.getPosts.url, method: .get, headers: ApiCall.nonAuthHeaders)
            .validate()
            .responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getUser(from id: Int, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request(Endpoints.getUser(id: id).url, method: .get, headers: ApiCall.nonAuthHeaders)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        AF.request(Endpoints.getComments.url, method: .get, headers: ApiCall.nonAuthHeaders)
            .validate()
            .responseDecodable(of: [Comment].self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        AF.request(Endpoints.getAlbums.url, method: .get, headers: ApiCall.nonAuthHeaders)
            .validate()
            .responseDecodable(of: [Album].self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        AF.request(Endpoints.getPhotos.url, method: .get, headers: ApiCall.nonAuthHeaders)
            .validate()
            .responseDecodable(of: [Photo].self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
