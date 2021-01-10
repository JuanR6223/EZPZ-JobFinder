//
//  YourProfile_Screen.swift
//  JobFinder
//
//  Created by Apple on 7/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Foundation

class YourProfilePage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarItems()
    }
    
    
    private func setUpNavigationBarItems() {
        let logOutButton =  UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(menuButtonTapped))
        
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    @objc fileprivate func menuButtonTapped() {
        performSegue(withIdentifier: "LogOutSegue", sender: nil)
    }
}
