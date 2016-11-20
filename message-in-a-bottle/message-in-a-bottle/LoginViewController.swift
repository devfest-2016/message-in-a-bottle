//
//  LoginViewController.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var firstnameTextField: UITextField!
    var lastnameTextField: UITextField!
    
    var loginButton: UIButton!
    var newuserButton: UIButton!
    var signupButton: UIButton!
    var cancelButton: UIButton!

    var signupButtonState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.themeBrightBlue
        loadViews()
        
    }
    
    func animateSignupEntry(view: UIView) {

        UIView.animate(withDuration: 0.25, animations: {
            view.center.y = self.view.center.y
        }) { (success) in
            print(success)
        }
    }

    func createAlertWith(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: nil))
        
        return alert
    }
    
}


extension LoginViewController {
    
    func loginButtonAction() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if email != "" && password != "" {
            FirebaseMethods.signInButton(email: email, password: password) { success in
                if success {
                    self.performSegue(withIdentifier: "landingSegue", sender: self)
                } else {
                    let alert = self.createAlertWith(title: "Couldn't Login", message: "Please Check Your Entries")
                    self.present(alert, animated: true, completion: { 
                        
                    })
                }
            }
        } else if email == "" && password != "" {
            let alert = self.createAlertWith(title: "Uh Oh", message: "You need an email.")
            self.present(alert, animated: true, completion: {
                
            })
        } else if password == "" && email != "" {
            let alert = self.createAlertWith(title: "Uh Oh", message: "You need a password.")
            self.present(alert, animated: true, completion: {
                
            })
        } else {
            let alert = self.createAlertWith(title: "Uh Oh", message: "You need to enter some info.")
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    
    func newuserButtonAction(_ sender: UIButton) {
        //animate to signup setup
    }
    
    func signupButtonAction(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let firstName = firstnameTextField.text else {return}
        guard let lastName = lastnameTextField.text else {return}
        
        if email != "" && password != "" && firstName != "" && lastName != "" {
            
        } else {
            let alert = self.createAlertWith(title: "Uh Oh", message: "The oceans are rough")
            self.present(alert, animated: true, completion: {
                
            })
        }
        FirebaseMethods.signUpButton(email: email, password: password, firstName: firstName, lastName: lastName) { success in
            
        }
   
        
    }
    
    func cancelButtonAction(_ sender: UIButton) {
        //animate back to login setup
 
    }
    
    
    
}


//MARK: -Animations
extension LoginViewController {
    
    
    
    
    
}




//MARK: -Setup buttons
extension LoginViewController {
    func loadViews() {
        
        emailTextField = UITextField(frame: CGRect(x: self.view.frame.size.width * 0.125, y: self.view.frame.size.height * 0.1, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.08))
        emailTextField.backgroundColor = UIColor.cyan
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        self.view.addSubview(emailTextField)
        passwordTextField = UITextField(frame: CGRect(x: self.view.frame.size.width * 0.125, y: self.view.frame.size.height * 0.2, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.08))
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = UIColor.cyan
        self.view.addSubview(passwordTextField)
        firstnameTextField = UITextField(frame: CGRect(x: self.view.frame.size.width * 0.125, y: self.view.frame.size.height * 0.3, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.08))
        firstnameTextField.autocorrectionType = .no
        firstnameTextField.backgroundColor = UIColor.cyan
        self.view.addSubview(firstnameTextField)
        lastnameTextField = UITextField(frame: CGRect(x: self.view.frame.size.width * 0.125, y: self.view.frame.size.height * 0.4, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.08))
        lastnameTextField.autocorrectionType = .no
        lastnameTextField.backgroundColor = UIColor.cyan
        self.view.addSubview(lastnameTextField)
        
        loginButton = UIButton(frame: CGRect(x: self.view.frame.size.width * 0.25, y: self.view.frame.size.height * 0.6, width: self.view.frame.size.width * 0.5, height: self.view.frame.size.height * 0.08))
        self.view.addSubview(loginButton)
        loginButton.backgroundColor = UIColor.cyan
        loginButton.titleLabel?.text = "Signup"
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        newuserButton = UIButton(frame: CGRect(x: self.view.frame.size.width * 0.25, y: self.view.frame.size.height * 0.7, width: self.view.frame.size.width * 0.5, height: self.view.frame.size.height * 0.08))
        self.view.addSubview(signupButton)
        newuserButton.backgroundColor = UIColor.cyan
        newuserButton.titleLabel?.text = "Signup"
        newuserButton.addTarget(self, action: #selector(newuserButtonAction), for: .touchUpInside)
        
        signupButton = UIButton(frame: CGRect(x: self.view.frame.size.width * 0.25, y: self.view.frame.size.height * 0.7, width: self.view.frame.size.width * 0.5, height: self.view.frame.size.height * 0.08))
        self.view.addSubview(signupButton)
        signupButton.backgroundColor = UIColor.cyan
        signupButton.titleLabel?.text = "Signup"
        signupButton.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        
        cancelButton = UIButton(frame: CGRect(x: self.view.frame.size.width * 0.25, y: self.view.frame.size.height * 0.8, width: self.view.frame.size.width * 0.5, height: self.view.frame.size.height * 0.08))
        self.view.addSubview(cancelButton)
        cancelButton.backgroundColor = UIColor.red
        cancelButton.titleLabel?.text = "Cancel"
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
    }
}




