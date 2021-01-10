//
//  BusinessTableViewController.swift
//  ChicagoRestaurants
//
//  Created by Westside Health Authority on 12/8/20.
//  Copyright © 2020 Westside Health Authority. All rights reserved.
//

import UIKit
import SafariServices

class BusinessTableViewController: UITableViewController, SFSafariViewControllerDelegate {

    @IBOutlet var jobsTableView: UITableView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobCreatedLabel: UILabel!
    @IBOutlet weak var jobLabelLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    
    var job: Result?
    //var annotation: MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyNameLabel.text = job?.company.displayName
        jobTitleLabel.text = job?.title
        descriptionLabel.text = "\(job!.description)                                                                                                                                                Apply to Learn More"
        jobCreatedLabel.text = job?.created
        jobLabelLabel.text = job?.location.displayName
        applyButton.layer.cornerRadius = 5
        
          jobsTableView.reloadData()
    }
    
    @IBAction func linkPressed(_ sender: Any) {
        let link = job?.redirectUrl
        let vc = SFSafariViewController(url: URL(string: link!)!)
        present(vc, animated: true)
    }
    
}
