//
//  SignInVC.swift
//  ChatAppIos10
//
//  Created by Petr on 07.11.17.
//  Copyright © 2017 Andi. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 8
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUsername()
        if AuthService.instance.isLoggedIn {performSegue(withIdentifier: "showMainVC", sender: nil)
        }
    }
    
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        func setUsername() {
            if let user = Auth.auth().currentUser {
                AuthService.instance.isLoggedIn = true
                let emailComponents = user.email?.components(separatedBy: "@")
                if let username = emailComponents?[0] {
                    AuthService.instance.username = username
                }
            } else {
                AuthService.instance.isLoggedIn = false
                AuthService.instance.username = nil
            }
        }
    }

