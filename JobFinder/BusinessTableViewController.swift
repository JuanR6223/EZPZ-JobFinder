//
//  BusinessTableViewController.swift
//  ChicagoRestaurants
//
//  Created by Westside Health Authority on 12/8/20.
//  Copyright © 2020 Westside Health Authority. All rights reserved.
//

import UIKit
import SafariServices
import MapKit

class BusinessTableViewController: UITableViewController, SFSafariViewControllerDelegate, MKMapViewDelegate {

    @IBOutlet var jobsTableView: UITableView!
    @IBOutlet weak var detailMapView: MKMapView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobCreatedLabel: UILabel!
    @IBOutlet weak var jobLabelLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    
    var job: Result?
    var annotation: MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailMapView.delegate = self
    
        var annotations = [MKPointAnnotation]()

        companyNameLabel.text = job?.company.displayName
        jobTitleLabel.text = job?.title
        descriptionLabel.text = "\(job!.description)                                                                                                                                                Apply to Learn More"
        jobCreatedLabel.text = job?.created
        jobLabelLabel.text = job?.location.displayName
        applyButton.layer.cornerRadius = 5
        detailMapView.showsUserLocation = true
        detailMapView.userLocation.title = "My Location"
        
        if let latitude = job?.latitude, let longitude = job?.longitude {
            let annotation = MKPointAnnotation()
            annotation.title = job?.company.displayName
            annotation.subtitle = job?.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotations.append(annotation)
        }
        
        self.detailMapView.showAnnotations(annotations, animated: false)
        let region = MKCoordinateRegion( center: detailMapView.userLocation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 4000)!, longitudinalMeters: CLLocationDistance(exactly: 4000)!)
        detailMapView.setRegion(region, animated: true)
        jobsTableView.reloadData()
        
    }
    
    @IBAction func linkPressed(_ sender: Any) {
        let link = job?.redirectUrl
        let vc = SFSafariViewController(url: URL(string: link!)!)
        present(vc, animated: true)
    }
    
//    func centerToLocation (location: CLLocation) {
//        let region = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
//
//        detailMapView.setRegion(region, animated: true)
//    }
}
