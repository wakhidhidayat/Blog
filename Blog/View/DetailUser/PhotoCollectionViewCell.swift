//
//  PhotoCollectionViewCell.swift
//  Blog
//
//  Created by Wahid Hidayat on 05/01/22.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    
    static let identifier = "PhotoCollectionViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    func configure(with photo: Photo) {
        photoImage.kf.setImage(with: URL(string: photo.thumbnailUrl), options: [.transition(.fade(0.2))])
    }
}
