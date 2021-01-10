//
//  ClusterDetailTableViewController.swift
//  JobFinder
//
//  Created by Westside Health Authority on 12/17/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import MapKit

class ClusterDetailTableViewController: UITableViewController {

    var memberAnnotations = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memberAnnotations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let annotation = memberAnnotations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "clusterCellID", for: indexPath)
        cell.textLabel!.text = annotation.title as! String
        cell.detailTextLabel?.text = annotation.subtitle as! String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? DetailMapViewController {
            dvc.annotation = memberAnnotations[tableView.indexPathForSelectedRow!.row]
        }
    }
}
