//
//  RegisterScreen.swift
//  ProjectPart-2
//

import UIKit
import FirebaseAuth

class RegisterScreen: UIViewController {

//    @IBOutlet weak var newEmailInput: UITextField!
//    @IBOutlet weak var newPasswordInput: UITextField!
//
    @IBOutlet weak var newEmailINput: UITextField!
    @IBOutlet weak var newPasswordInput: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newEmailFieldClicked(_ sender: UITextField) {
        if((newEmailINput.text != "") && (newPasswordInput.text != "")){
            registerButton.isEnabled = true;
        } else {
            registerButton.isEnabled = false;
        }
    }
    
    @IBAction func newPasswordFieldClicked(_ sender: UITextField) {
        if((newEmailINput.text != "") && (newPasswordInput.text != "")){
            registerButton.isEnabled = true;
        } else {
            registerButton.isEnabled = false;
        }
    }
    
    @IBAction func OnRegisterUserClick(_ sender: UIButton) {
        
        let email = newEmailINput.text ?? ""
        let password = newPasswordInput.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password){[weak self] authResult, error in
            print("New User Created!")
            self!.dismiss(animated: true)            
        }
    }

}
