//
//  SignInTestViewController.swift
//  JobFinder
//
//  Created by Westside Health Authority on 11/19/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let authUI = FUIAuth.defaultAuthUI()
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
    
    
}
