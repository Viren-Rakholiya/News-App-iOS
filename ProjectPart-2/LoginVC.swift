//
//  LoginVC.swift
//  ProjectPart-2
//
//  Created by Viren Rakholiya on 14/08/22.
//

import UIKit
import FirebaseAuth
class LoginVC: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var emailMessage: UILabel!

    @IBOutlet weak var passwordMessage: UILabel!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.isEnabled = false
        emailMessage.text = ""
        passwordMessage.text = ""
    }
    
    @IBAction func emailFieldTap(_ sender: UITextField) {
        if(sender.text == ""){
            emailMessage.isHidden = false
            emailMessage.text = "Please Enter Valid Email"
        } else {
            emailMessage.isHidden = false
        }
        
        if((emailInput.text != "") && (passwordInput.text != "")){
            loginButton.isEnabled = true;
        } else {
            loginButton.isEnabled = false;
        }
    }
    @IBAction func passwordFieldTap(_ sender: UITextField) {
        if(sender.text == ""){
            passwordMessage.isHidden = false
            passwordMessage.text = "Please Enter Valid Password"
        } else {
            passwordMessage.isHidden = false
        }
        if((emailInput.text != "") && (passwordInput.text != "")){
            loginButton.isEnabled = true;
        } else {
            loginButton.isEnabled = false;
        }
    }
 
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        let email = emailInput.text ?? ""
        let password = passwordInput.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password){[weak self] authResult, error in
            guard let strongSelf = self else {
                print("Login Sucess!")
                return
            }
            
            if error != nil {
                strongSelf.showAlert()
                return
            }
            
            strongSelf.navigateToNewsScreen()
        }
        
    }
    private func navigateToNewsScreen() {
        performSegue(withIdentifier: "ToNewsFeedScreen", sender: self)
        passwordInput.text = ""
    }
    private func navigateToRegisterScreen() {
        performSegue(withIdentifier: "ToRegisterScreen", sender: self)
        passwordInput.text = ""
    }
    private func showAlert(){
        let message = "Try Again"
        let alert2 = UIAlertController(title: "Authentication", message: message, preferredStyle: .alert)

        let okButton = UIAlertAction(title: "Ok", style: .default) { _ in

            print("Ok button is pressed")
        }

        alert2.addAction(okButton)
        self.show(alert2, sender: nil)
        passwordInput.text = ""
    }
    
    @IBAction func onClickNewUser(_ sender: UIButton) {
        navigateToRegisterScreen()
        emailInput.text = ""
        passwordInput.text = ""
    }
}
