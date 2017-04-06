//
//  SignInViewController.swift
//  kikis
//
//  Created by Maxim on 21/12/2016.
//  Copyright © 2016 Kulvinder. All rights reserved.
//

import UIKit
import Buy
import MBProgressHUD

class SignInViewController: UIViewController {
    
    weak var delegate: AuthenticationDelegate?
    
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    private var email:    String { return self.txt_email.text    ?? "" }
    private var password: String { return self.txt_password.text ?? "" }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign In"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func clear() {
        self.txt_email.text     = ""
        self.txt_password.text  = ""
    }
    
    @IBAction func onClick_SignIn(_ sender: Any) {
        
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
        
        let credentials  = BUYAccountCredentials(items: [
            BUYAccountCredentialItem(email: self.email),
            BUYAccountCredentialItem(password: self.password),
            ])
        
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        spinnerActivity.detailsLabel.text = "Please Wait..."
        
        BUYClient.sharedClient.loginCustomer(with: credentials) { (customer, token, error) in
            
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
    
    @IBAction func onClick_forgotpw(_ sender: Any) {
        
    }

    
}
