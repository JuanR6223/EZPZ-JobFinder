//
//  ProfileTableViewController.swift
//  JobFinder
//
//  Created by Student on 11/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var profileTableView: UITableView!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var educationLevel: UITextField!
    
    @IBOutlet weak var stateLocation: UITextField!
    @IBOutlet weak var cityLocation: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var interestedPosition1: UITextField!
    @IBOutlet weak var interestedPosition2: UITextField!
    @IBOutlet weak var interestedPosition3: UITextField!
    
    @IBOutlet weak var interestedCauses1: UITableViewCell!
    @IBOutlet weak var interestedCauses2: UITableViewCell!
    @IBOutlet weak var interestedCauses3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.separatorStyle = .none
        profileTableView.showsVerticalScrollIndicator = false
        
    }
}
