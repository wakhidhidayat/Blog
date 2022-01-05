//
//  DetailPostViewModel.swift
//  Blog
//
//  Created by Wahid Hidayat on 04/01/22.
//

import Foundation

class DetailPostViewModel {
    var isLoading = Box(false)
    var error: Box<Error?> = Box(nil)
    var comments = Box([Comment]())
    
    init(postId: Int) {
        getComments(postId: postId)
    }
    
    func getComments(postId: Int) {
        error.value = nil
        isLoading.value = true
        
        NetworkService.shared.getComments { [weak self] result in
            switch result {
            case .success(let comments):
                let filteredComments = comments.filter { comment in
                    comment.postId == postId
                }
                self?.comments.value = filteredComments
                self?.isLoading.value = false
            case .failure(let error):
                debugPrint(error)
                self?.isLoading.value = false
            }
        }
    }
}
