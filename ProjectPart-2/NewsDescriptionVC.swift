//
//  NewsDescriptionVC.swift
//  ProjectPart-2
//

import UIKit

class NewsDescriptionVC: UIViewController {

    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var txtDescription: UITextView!
    
    var imgNewsStr: String = ""
    var txtTitleStr: String?
    var txtDescriptionStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        imgNews.text = imgNewsStr
        txtTitle.text = txtTitleStr
        let data = try? Data(contentsOf: URL(string: imgNewsStr)!)
        imgNews.image = UIImage(data: data!)
        txtDescription.text = txtDescriptionStr
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
