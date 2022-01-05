//
//  DetailUserViewController.swift
//  Blog
//
//  Created by Wahid Hidayat on 05/01/22.
//

import UIKit

class DetailUserViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var albumTable: UITableView!
    
    private let viewModel: DetailUserViewModel
    private let userId: Int
    
    init(viewModel: DetailUserViewModel, userId: Int) {
        self.viewModel = viewModel
        self.userId = userId
        super.init(nibName: "DetailUserViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup ui
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Detail User"
        
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        
        albumTable.register(AlbumTableViewCell.nib, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        albumTable.dataSource = self
        albumTable.delegate = self
        albumTable.rowHeight = 120
        
        // data binding
        viewModel.user.bind { [weak self] user in
            guard let user = user else { return }
            
            self?.usernameLabel.text = user.name
            self?.emailLabel.text = user.email
            self?.addressLabel.text = "\(user.address.street), \(user.address.suite), \(user.address.city) (\(user.address.zipcode))"
            self?.companyLabel.text = user.company.name
        }
        
        viewModel.albums.bind { [weak self] albums in
            for album in albums {
                self?.viewModel.getPhotos(from: album.id)
            }
        }
        
        viewModel.photos.bind { [weak self] _ in
            self?.albumTable.reloadData()
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator.startAnimating()
                self?.contentView.isHidden = true
            } else {
                self?.activityIndicator.stopAnimating()
                self?.contentView.isHidden = false
            }
        }
        
        viewModel.error.bind { error in
            if let error = error {
                debugPrint(error)
            }
        }
    }
}

extension DetailUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AlbumTableViewCell.identifier,
            for: indexPath
        ) as? AlbumTableViewCell
        let album = viewModel.albums.value[indexPath.row]
        cell?.configure(album: album, photos: viewModel.photos.value.filter { $0.albumId == album.id })
        return cell ?? UITableViewCell()
    }
}

extension DetailUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
