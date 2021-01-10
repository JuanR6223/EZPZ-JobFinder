//
//  ViewController.swift
//  JobFinder
//
//  Created by Apple on 7/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var viewLeading: NSLayoutConstraint!
    @IBOutlet var viewTrailing: NSLayoutConstraint!
    
    
    var menuOut = false

     
     override func viewDidLoad() {
         super.viewDidLoad()
     }

    @IBAction func menuPressed(_ sender: Any) {

        if menuOut == false {
            viewLeading.constant = -150
            viewTrailing.constant = 150
            menuOut = true
        } else {
            viewLeading.constant = 0
            viewTrailing.constant = 0
            menuOut = false
               }
           
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
        self.view.layoutIfNeeded()
            })

    }
    
    
}

