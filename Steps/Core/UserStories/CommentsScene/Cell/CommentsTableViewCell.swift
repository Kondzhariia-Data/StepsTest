//
//  CommentsTableViewCell.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright © 2020 Steps. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
}

// MARK: - Public Methods
extension CommentsTableViewCell {

    public func configure(comment: Comments.DisplayedComment) {
        idLabel.text = "\(comment.id)"
        nameLabel.text = comment.name
        emailLabel.text = comment.email
        bodyLabel.text = comment.body
    }
}
