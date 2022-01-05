//
//  DetailPostViewController.swift
//  Blog
//
//  Created by Wahid Hidayat on 04/01/22.
//

import UIKit

class DetailPostViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIStackView!
    
    private let viewModel: DetailPostViewModel
    private let post: PostList
    
    init(viewModel: DetailPostViewModel, post: PostList) {
        self.viewModel = viewModel
        self.post = post
        super.init(nibName: "DetailPostViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup ui
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Detail Post"
        
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        
        commentTable.register(CommentTableViewCell.nib, forCellReuseIdentifier: CommentTableViewCell.identifier)
        commentTable.dataSource = self
        commentTable.delegate = self
        commentTable.rowHeight = 130
        
        // data binding
        viewModel.comments.bind { [weak self] _ in
            self?.titleLabel.text = self?.post.title
            self?.userButton.setTitle(self?.post.user, for: .normal)
            self?.bodyLabel.text = self?.post.body
            self?.commentTable.reloadData()
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
    
    @IBAction func userButtonAction(_ sender: UIButton) {
        // todo
    }
}

extension DetailPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentTableViewCell.identifier,
            for: indexPath
        ) as? CommentTableViewCell
        cell?.configure(with: viewModel.comments.value[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
}

extension DetailPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
