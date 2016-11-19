//
//  LoginViewController.swift
//  message-in-a-bottle
//
//  Created by Benjamin Su on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signupview: SignupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        User.retrieveUser(with: "L0HzRRZn1GZhXjEfdaT35q5N3ck2") { (user) in
            dump(user)
        }
        self.view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view.
        signupview = SignupView(frame: CGRect(x: self.view.frame.size.width * 0.125, y: self.view.frame.size.height, width: self.view.frame.size.width * 0.75, height: self.view.frame.size.height * 0.6))
        signupview.loadViews()
        self.view.addSubview(signupview)
    }

    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        FirebaseMethods.signInButton(email: email, password: password)
        
    }
    
    
    @IBAction func signupButtonAction(_ sender: UIButton) {
        
        animateSignupEntry(view: signupview)
        
    }
    
    func animateSignupEntry(view: UIView) {

        UIView.animate(withDuration: 0.25, animations: {
            view.center.y = self.view.center.y
        }) { (success) in
            print(success)
        }
    }

}


class SignupView: UIView {
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var firstnameTextField: UITextField!
    var lastnameTextField: UITextField!
    
    var signupButton: UIButton!
    var cancelButton: UIButton!
    
    
    func loadViews() {
        self.backgroundColor = UIColor.brown

        emailTextField = UITextField(frame: CGRect(x: frame.size.width * 0.125, y: frame.size.height * 0.1, width: frame.size.width * 0.75, height: frame.size.height * 0.08))
        emailTextField.backgroundColor = UIColor.cyan
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        self.addSubview(emailTextField)
        passwordTextField = UITextField(frame: CGRect(x: frame.size.width * 0.125, y: frame.size.height * 0.2, width: frame.size.width * 0.75, height: frame.size.height * 0.08))
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = UIColor.cyan
        self.addSubview(passwordTextField)
        firstnameTextField = UITextField(frame: CGRect(x: frame.size.width * 0.125, y: frame.size.height * 0.3, width: frame.size.width * 0.75, height: frame.size.height * 0.08))
        firstnameTextField.autocorrectionType = .no
        firstnameTextField.backgroundColor = UIColor.cyan
        self.addSubview(firstnameTextField)
        lastnameTextField = UITextField(frame: CGRect(x: frame.size.width * 0.125, y: frame.size.height * 0.4, width: frame.size.width * 0.75, height: frame.size.height * 0.08))
        lastnameTextField.autocorrectionType = .no
        lastnameTextField.backgroundColor = UIColor.cyan
        self.addSubview(lastnameTextField)
        
        signupButton = UIButton(frame: CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.6, width: frame.size.width * 0.5, height: frame.size.height * 0.08))
        self.addSubview(signupButton)
        signupButton.backgroundColor = UIColor.cyan
        signupButton.titleLabel?.text = "Signup"
        signupButton.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        
        cancelButton = UIButton(frame: CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.7, width: frame.size.width * 0.5, height: frame.size.height * 0.08))
        self.addSubview(cancelButton)
        cancelButton.backgroundColor = UIColor.red
        cancelButton.titleLabel?.text = "Cancel"
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
    }
    
    
    func signupButtonAction(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let firstName = firstnameTextField.text else {return}
        guard let lastName = lastnameTextField.text else {return}
        FirebaseMethods.signUpButton(email: email, password: password, firstName: firstName, lastName: lastName)
        animateSignupExit()
        
    }
    
    func cancelButtonAction(_ sender: UIButton) {
        
        animateSignupExit()
       
    }
    
    
    func animateSignupExit() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.center.y = self.center.y + UIScreen.main.bounds.height
        }) { (success) in
            print(success)
        }
    }
    
}





