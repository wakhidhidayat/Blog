//
//  AlbumTableViewCell.swift
//  Blog
//
//  Created by Wahid Hidayat on 05/01/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoCollection: UICollectionView!
    
    static let identifier = "AlbumTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    var photos = [Photo]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoCollection.register(
            PhotoCollectionViewCell.nib,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        photoCollection.dataSource = self
        photoCollection.delegate = self
    }
    
    func configure(album: Album, photos: [Photo]) {
        self.titleLabel.text = album.title
        self.photos = photos.filter { $0.albumId == album.id }
        self.photoCollection.reloadData()
    }
}

extension AlbumTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath
        ) as? PhotoCollectionViewCell
        cell?.configure(with: photos[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension AlbumTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("albumId: \(photos[indexPath.row].albumId)")
    }
}

extension AlbumTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
