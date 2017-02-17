//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    
    @IBOutlet weak var repoTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        repoTableView.dataSource = self
        repoTableView.delegate = self
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            self.repos = newRepos
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        /*if let repos = repos {
            return repos.count
        }
        else {
            return 0;
        }*/
        return 5;

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = repoTableView.dequeueReusableCell(withIdentifier: "GithubRepoCell") as! GithubRepoCell
        
        let repo = repos![indexPath.row]
        

        if let imageUrl = URL(string: repo.ownerAvatarURL!) {
                cell.repoImageView.setImageWith(imageUrl)
            } else {
                // URL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
            }
        cell.authorLable.text = repo.ownerHandle
        cell.descriptionLable.text = repo.repoDescription
        cell.repoNameLable.text = repo.name
        let stars = "\(repo.stars)" as String
        let forks = "\(repo.forks)" as String
        
        cell.starNumLable.text = stars
        cell.linkNumLable.text = forks
        
        cell.linkImageView.image = UIImage(named: "star")
        cell.starImageView.image = UIImage(named: "fork")
            

        
        return cell;
        
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
