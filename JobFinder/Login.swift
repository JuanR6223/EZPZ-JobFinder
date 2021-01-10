//
//  Login.swift
//  JobFinder
//
//  Created by Apple on 7/28/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn
class Login: UIViewController {

    @IBOutlet var signInButton: GIDSignInButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 7.0
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

}
