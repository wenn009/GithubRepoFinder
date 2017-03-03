//
//  settingViewController.swift
//  GithubDemo
//
//  Created by Wenn Huang on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class settingViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var mySlider: UISlider!
    var settings : GithubRepoSearchSettings!
    var delegate:SettingsPresentingViewControllerDelegate?
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            numberLabel.text = String("\(settings?.minStars)")
            //mySlider.value = Float(settings.minStars)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func saveAction(_ sender: Any) {
        
        settings?.minStars = Int(mySlider.value);
        self.delegate?.didSaveSettings(settings: settings!)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sliderValueAction(_ sender: UISlider) {
        let numOfstars = Int(mySlider.value)
        numberLabel.text = "\(numOfstars)"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}
