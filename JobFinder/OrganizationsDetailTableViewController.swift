//
//  AfterSchoolMattersTableViewController.swift
//  JobFinder
//
//  Created by Westside Health Authority on 12/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SafariServices

class OrganizationsDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var applyNowButtonSpring: UIButton!
    @IBOutlet weak var applyNowButtonSummer: UIButton!
    @IBOutlet weak var applyNowButtonFall: UIButton!
    @IBOutlet weak var organizationImage: UIImageView!
    @IBOutlet weak var aboutUsLable: UILabel!
    @IBOutlet weak var springAppPeriodLabel: UILabel!
    @IBOutlet weak var summerAppPeriodLabel: UILabel!
    @IBOutlet weak var fallAppPeriodLabel: UILabel!
    
    //var org: UIImage = UIImage(named: "AfterSchoolMatters")!
    var org = ""
    var aboutUs = ""
    var aboutUsURL = ""
    var springApplication = ""
    var summerApplication = ""
    var fallApplication = ""
    var springURL = ""
    var summerURL = ""
    var fallURL = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        organizationImage.image = UIImage(named: org)
        aboutUsLable.text = aboutUs
        springAppPeriodLabel.text = springApplication
        summerAppPeriodLabel.text = summerApplication
        fallAppPeriodLabel.text = fallApplication
        
        
        applyNowButtonSpring.layer.cornerRadius = 5
        applyNowButtonSummer.layer.cornerRadius = 5
        applyNowButtonFall.layer.cornerRadius = 5
    }
    
    @IBAction func learnMorePressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: aboutUsURL)!)
        present(vc, animated: true)
    }
    
    @IBAction func springApplyPressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: springURL)!)
        present(vc, animated: true)
    }
    
    @IBAction func summerApplyPressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: summerURL)!)
        present(vc, animated: true)
    }
    
    @IBAction func fallApplyPressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: fallURL)!)
        present(vc, animated: true)
    }
}
