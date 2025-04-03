//
//  ViewController.swift
//  Firebase-Instagram-Clone
//
//  Created by Punhan Shahmurov on 01.04.25.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func signUp(_ sender: Any) {
        
        if emailLabel.text != "" && passwordLabel.text != "" {
            
            Auth.auth().createUser(withEmail: emailLabel.text!, password: passwordLabel.text!) { (result, error) in
            
                if error != nil {
                    
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
                
            }
            
        } else{
          
            makeAlert(title: "Error", message: "Email or password is empty")
            
        }
        
        
        
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        if emailLabel.text != "" && passwordLabel.text != "" {
            
            Auth.auth().signIn(withEmail: emailLabel.text!, password: passwordLabel.text!) { (result, error) in
                
                if error != nil {
                    
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
                
            }
            
            
        } else{
            makeAlert(title: "Error", message: "Email or password is empty")
        }
        
    }
    
    func makeAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(okButton)
          self.present(alert, animated: true, completion: nil)
    }
    
}

