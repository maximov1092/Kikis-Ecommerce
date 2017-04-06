//
//  ViewController.swift
//  kikis
//
//  Created by Maxim on 21/12/2016.
//  Copyright © 2016 Kulvinder. All rights reserved.
//

import UIKit
import Buy


class ViewController: UIViewController {

    private var signinVC : SignInViewController!
    private var signupVC : SignUpViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("gosignin"):
            self.signinVC = segue.destination as! SignInViewController
            self.signinVC.delegate = self
            
        case .some("gosignup"):
            self.signupVC = segue.destination as! SignUpViewController
            self.signupVC.delegate = self
            
        default:
            break
        }
        
    
    }
    

}

extension ViewController : AuthenticationDelegate {
    func authenticationDidSucceedForCustomer(_ customer: BUYCustomer, withToken token: String) {
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabbarcontroller")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    func authenticationDidFailWithError(_ error: NSError?) {
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
