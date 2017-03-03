//
//  repoCell.swift
//  GithubDemo
//
//  Created by Ekko Lin on 2/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class repoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    
    var repo: GithubRepo! {
        didSet {
            titleLabel.text = repo.name!
            posterView.setImageWith(URL(string: repo.ownerAvatarURL!)!)
            starLabel.text = "\(repo.stars!)"
            forkLabel.text = "\(repo.forks!)"
            overviewLabel.text = "\(repo.repoDescription!)"
            authorLabel.text = "\(repo.ownerHandle!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
