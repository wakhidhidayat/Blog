//
//  CommentTableViewCell.swift
//  Blog
//
//  Created by Wahid Hidayat on 04/01/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    static let identifier = "CommentTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    func configure(with comment: Comment) {
        authorLabel.text = comment.name
        bodyLabel.text = comment.body
    }
}
