//
//  DetailPhotoViewController.swift
//  Blog
//
//  Created by Wahid Hidayat on 06/01/22.
//

import UIKit
import Kingfisher

class DetailPhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    private let viewModel: DetailPhotoViewModel
    
    init(viewModel: DetailPhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailPhotoViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        photoImage.enableZoom()
        viewModel.photo.bind { [weak self] photo in
            if let photo = photo {
                self?.photoImage.kf.setImage(with: URL(string: photo.url), options: [.transition(.fade(0.2))])
                self?.navigationItem.title = photo.title
            }
        }
    }
}
