//
//  DetailPhotoViewModel.swift
//  Blog
//
//  Created by Wahid Hidayat on 06/01/22.
//

import Foundation

class DetailPhotoViewModel {
    var photo: Box<Photo?> = Box(nil)
    
    init(photo: Photo) {
        self.photo.value = photo
    }
}
