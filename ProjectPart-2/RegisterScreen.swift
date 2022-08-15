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
    @IBOutlet weak var newPasswordMessage: UILabel!
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var newEmailMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.isEnabled = false
        newPasswordMessage.text = ""
        newEmailMessage.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newFirstNameClicked(_ sender: UITextField) {
        if((newEmailINput.text != "") && (newPasswordInput.text != "") &&
           (firstName.text != "") &&
           (lastName.text != "")){
            registerButton.isEnabled = true;
        } else {
            registerButton.isEnabled = false;
        }
    }
    @IBAction func newLastNameClicked(_ sender: UITextField) {
        if((newEmailINput.text != "") && (newPasswordInput.text != "") &&
           (firstName.text != "") &&
           (lastName.text != "")){
            registerButton.isEnabled = true;
        } else {
            registerButton.isEnabled = false;
        }
    }
    @IBAction func newEmailFieldClicked(_ sender: UITextField) {
        if((newEmailINput.text != "") && (newPasswordInput.text != "") &&
           (firstName.text != "") &&
           (lastName.text != "")){
            registerButton.isEnabled = true;
        } else {
            registerButton.isEnabled = false;
        }
        
    }
    
    @IBAction func newPasswordFieldClicked(_ sender: UITextField) {
        if((newEmailINput.text != "") && (newPasswordInput.text != "") &&
           (firstName.text != "") &&
           (lastName.text != "")){
            registerButton.isEnabled = true;
        } else {
            registerButton.isEnabled = false;
        }
    }
//    func isValidEmail(_ email: String) -> Bool {
//
//        return emailPred.evaluate(with: email)
//    }
    
    @IBAction func OnRegisterUserClick(_ sender: UIButton) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if(!emailPred.evaluate(with: newEmailINput.text)){
            newEmailMessage.text = "Enter valid email address"
        }
        if(newPasswordInput.text?.count ?? 0 < 6){
            print("Enter Valid Password")
            newPasswordMessage.text = "Enter more than 6 characters"
        } else {
            let email = newEmailINput.text ?? ""
            let password = newPasswordInput.text ?? ""

            Auth.auth().createUser(withEmail: email, password: password){[weak self] authResult, error in
                print("New User Created!")
                self!.dismiss(animated: true)
            }
        }
        
        
    }

}
