//
//  DetailUserViewModel.swift
//  Blog
//
//  Created by Wahid Hidayat on 05/01/22.
//

import Foundation

class DetailUserViewModel {
    var isLoading = Box(false)
    var error: Box<Error?> = Box(nil)
    var user: Box<User?> = Box(nil)
    var albums = Box([Album]())
    var photos = Box([Photo]())
    
    init(userId: Int) {
        getUser(from: userId)
        getAlbums(from: userId)
    }
    
    func getUser(from userId: Int) {
        user.value = nil
        error.value = nil
        isLoading.value = true
        
        NetworkService.shared.getUser(from: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user.value = user
            case .failure(let error):
                debugPrint(error)
                self?.isLoading.value = false
            }
        }
    }
    
    func getAlbums(from userId: Int) {
        albums.value.removeAll()
        error.value = nil
        isLoading.value = true
        
        NetworkService.shared.getAlbums { [weak self] result in
            switch result {
            case .success(let albums):
                let filteredAlbums = albums.filter { $0.userId == userId }
                self?.albums.value = filteredAlbums
            case .failure(let error):
                debugPrint(error)
                self?.isLoading.value = false
            }
        }
    }
    
    func getPhotos(from albumId: Int) {
        error.value = nil
        isLoading.value = true
        
        NetworkService.shared.getPhotos { [weak self] result in
            switch result {
            case .success(let photos):
                let filteredPhotos = photos.filter { $0.albumId == albumId }
                self?.photos.value.append(contentsOf: filteredPhotos)
                self?.isLoading.value = false
            case .failure(let error):
                debugPrint(error)
                self?.isLoading.value = false
            }
        }
    }
}
