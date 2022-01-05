//
//  PostViewModel.swift
//  Blog
//
//  Created by Wahid Hidayat on 03/01/22.
//

import Foundation

class PostViewModel {
    var listPost = Box([PostList]())
    var isLoading = Box(false)
    var error: Box<Error?> = Box(nil)
    var posts = Box([Post]())
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        error.value = nil
        isLoading.value = true
        
        NetworkService.shared.getPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts.value = posts
                self?.isLoading.value = false
            case .failure(let error):
                debugPrint(error)
                self?.isLoading.value = false
            }
        }
    }
    
    func getPostList(userId: Int, post: Post) {
        NetworkService.shared.getUser(from: userId) { [weak self] result in
            switch result {
            case .success(let user):
                let postList = PostList(
                    id: post.id,
                    title: post.title,
                    body: post.body,
                    user: user.name,
                    company: user.company.name,
                    userId: user.id
                )
                self?.listPost.value.append(postList)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
