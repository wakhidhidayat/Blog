//
//  PostTableViewCell.swift
//  Blog
//
//  Created by Wahid Hidayat on 03/01/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    static let identifier = "PostTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
        
    func configure(with post: PostList) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
        organizationLabel.text = post.company
        userLabel.text = post.user
    }
}
