//
//  GithubRepoCell.swift
//  GithubDemo
//
//  Created by Wenn Huang on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class GithubRepoCell: UITableViewCell {

    @IBOutlet weak var repoNameLable: UILabel!
    @IBOutlet weak var starNumLable: UILabel!
    @IBOutlet weak var linkNumLable: UILabel!
    @IBOutlet weak var byLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var linkImageView: UIImageView!
    
    var repo: GithubRepo! {
        didSet {
            repoNameLable.text = repo.name!
            repoImageView.setImageWith(URL(string: repo.ownerAvatarURL!)!)
            starNumLable.text = "\(repo.stars!)"
            linkNumLable.text = "\(repo.forks!)"
            descriptionLable.text = "\(repo.repoDescription!)"
            authorLable.text = "\(repo.ownerHandle!)"
            linkImageView.image = UIImage(named: "fork")
            starImageView.image = UIImage(named: "star")
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
