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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
