import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, SettingsPresentingViewControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
        
        if let repos = repos {
            for repo in repos {
                print(repo.name!)
                print(repo.ownerHandle!)
                print(repo.forks!)
                print(repo.stars!)
                print(repo.ownerAvatarURL!)
                print(repo.repoDescription!)
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repos != nil {
            return repos!.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! repoCell
        
        cell.repo = repos[indexPath.row]
        
        return cell;
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
            self.tableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error?.localizedDescription ?? 0)
        })
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! settingViewController
        vc.settings = searchSettings
        vc.delegate = self
        
    }
    func didSaveSettings(settings: GithubRepoSearchSettings){
        searchSettings = settings
        doSearch()
        self.tableView.reloadData()
    }
    func didCancelSettings() {
        
        // do something
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
