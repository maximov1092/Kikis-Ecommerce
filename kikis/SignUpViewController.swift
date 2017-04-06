//
//  SignUpViewController.swift
//  kikis
//
//  Created by Maxim on 21/12/2016.
//  Copyright © 2016 Kulvinder. All rights reserved.
//

import UIKit
import Buy
import MBProgressHUD

class SignUpViewController: UIViewController {

    weak var delegate: AuthenticationDelegate?
    
    @IBOutlet weak var txt_firstname: UITextField!
    @IBOutlet weak var txt_lastname: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_repassword: UITextField!
    
    private var firstName:       String { return self.txt_firstname.text       ?? "" }
    private var lastName:        String { return self.txt_lastname.text        ?? "" }
    private var email:           String { return self.txt_email.text           ?? "" }
    private var password:        String { return self.txt_password.text        ?? "" }
    private var passwordConfirm: String { return self.txt_repassword.text ?? "" }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sign Up"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func clear() {
        self.txt_firstname.text        = ""
        self.txt_lastname.text         = ""
        self.txt_email.text            = ""
        self.txt_password.text         = ""
        self.txt_repassword.text       = ""
    }
    
    @IBAction func onClick_Signup(_ sender: Any) {
        
        if self.txt_firstname.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Please input your first name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.txt_lastname.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Please input your last name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.txt_email.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Please input your email address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.txt_password.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Please input your password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.txt_repassword.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Please input your confirmed password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if self.txt_password.text != self.txt_repassword.text
        {
            self.txt_password.text         = ""
            self.txt_repassword.text       = ""
            let alert = UIAlertController(title: "Error", message: "Your password is not matched!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let credentials = BUYAccountCredentials(items: [
            BUYAccountCredentialItem(firstName: self.firstName),
            BUYAccountCredentialItem(lastName: self.lastName),
            BUYAccountCredentialItem(email: self.email),
            BUYAccountCredentialItem(password: self.password)
            ])
        
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        spinnerActivity.detailsLabel.text = "Please Wait..."
        
        BUYClient.sharedClient.createCustomer(with: credentials) { (customer, token, error) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if let customer = customer,
                let token = token {
                self.clear()
                self.delegate?.authenticationDidSucceedForCustomer(customer, withToken: token.accessToken)
            } else {
                self.delegate?.authenticationDidFailWithError(error as NSError?)
            }
        }
    }
    

}
