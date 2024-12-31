//
//  ViewController.swift
//  Hooked
//
//  Created by Emre on 11.12.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!){(authdata , error) in
                if error != nil {
                
                    self.makeAlert(titleInPut: "ERROR", messageInPut: error?.localizedDescription ?? "ERROR")
                    
                }else{
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
            
        }else {
            makeAlert(titleInPut: "ERROR", messageInPut: "UserName/Password?")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInPut: "ERROR", messageInPut: error?.localizedDescription ?? "ERROR")
                    
                }else {
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
        }else {
            makeAlert(titleInPut: "ERROR", messageInPut: "UserName/Password?")
        }
        }
    func makeAlert(titleInPut: String , messageInPut: String) {
        let alert = UIAlertController(title: titleInPut, message: messageInPut, preferredStyle:UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default , handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    }


