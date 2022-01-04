//
//  PostViewController.swift
//  Blog
//
//  Created by Wahid Hidayat on 03/01/22.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: PostViewModel
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "PostViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup ui
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Posts"
        
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        
        postTable.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        postTable.dataSource = self
        postTable.delegate = self
        postTable.rowHeight = 130
        
        // data binding
        viewModel.posts.bind { [weak self] _ in
            guard let self = self else { return }
            
            for post in self.viewModel.posts.value {
                self.viewModel.getPostList(userId: post.userId, post: post)
            }
        }
        
        viewModel.listPost.bind { [weak self] _ in
            self?.postTable.reloadData()
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.error.bind { error in
            if let error = error {
                debugPrint(error)
            }
        }
    }
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listPost.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.identifier,
            for: indexPath
        ) as? PostTableViewCell
        cell?.configure(with: viewModel.listPost.value[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
