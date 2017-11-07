//
//  MainVC.swift
//  ChatAppIos10
//
//  Created by Petr on 07.11.17.
//  Copyright © 2017 Andi. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        do
        {try Auth.auth().signOut()
            performSegue(withIdentifier: "showSignInVC", sender: nil)
        } catch {
            print("An error occurred signing out")
        }
    }
    
    @IBAction func sendMessageButtonTapped(_ sender: UIButton) {
        
        guard let messageText = messageTextField.text else {
            showAlert(title: "Error", message: "Please enter a message")
            
            return
            
        }
        guard messageText != "" else {
            showAlert(title: "Error", message: "No message to send")
            
            return
        }
        
        if let user = AuthService.instance.username {
            DataService.instance.saveMessage(user, message: messageText)
            messageTextField.text = ""
            dismissKeyboard()
            tableView.reloadData()
        }
    }
    
    func keyboardWillShow(notif: NSNotification) {
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notif: NSNotification) {
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    extension MainVC: DataServiceDelegate {
        func dataLoaded() {
            tableView.reloadData()
            if DataService.instance.messages.count > 0 {
                let indexPath = IndexPath(row: DataService.instance.messages.count - 1, section: 0)
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    extension MainVC: UITableViewDelegate, UITableViewDataSource {
        
}

