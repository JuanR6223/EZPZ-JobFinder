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
    var jobs = [Result]()
    
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
        cell.textLabel!.text = annotation.title as? String
        cell.detailTextLabel?.attributedText = convertHTMLText(text: annotation.subtitle!!)
        cell.detailTextLabel?.font = UIFont(name: "Avenir Next Regular", size: 12.0)

        
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
    
    func convertHTMLText(text: String) -> NSAttributedString {
        let data = Data(text.utf8)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue]
        var attritbutedText: NSMutableAttributedString?
        
        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            attritbutedText = attributedString
            return attributedString
        }
        return attritbutedText!
    }
}
