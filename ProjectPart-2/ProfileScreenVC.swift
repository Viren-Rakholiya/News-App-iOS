//
//  ProfileScreenVC.swift
//  ProjectPart-2
//

import UIKit

class ProfileScreenVC: UIViewController {

    @IBOutlet weak var username: UILabel!
    var userEmailID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        username.text = userEmailID
    }
    
    @IBAction func onClickHomeScreen(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onClickCountry(_ sender: UIButton) {
    }
    
    @IBAction func onClickSecurityPassword(_ sender: UIButton) {
    }
    
    @IBAction func onClickAccountSettings(_ sender: UIButton) {
    }
    
    @IBAction func onClickAbout(_ sender: UIButton) {
    }
    
    @IBAction func onClickHelp(_ sender: UIButton) {
    }
    
}
