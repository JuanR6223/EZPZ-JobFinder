//
//  DetailMapViewController.swift
//  JobFinder
//
//  Created by Westside Health Authority on 12/17/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import MapKit

class DetailMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailMapView: MKMapView!
    var annotation: MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailMapView.delegate = self

        if let annotation = annotation {
            detailMapView.showAnnotations([annotation], animated: true)
        }
        
        detailMapView.showsUserLocation = true
        detailMapView.userLocation.title = "My Location"
        
        let region = MKCoordinateRegion( center: detailMapView.userLocation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        detailMapView.setRegion(region, animated: true)
    }

//    func centerToLocation (location: CLLocation) {
//        let region = MKCoordinateRegion( center: detailMapView.userLocation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 100000)!, longitudinalMeters: CLLocationDistance(exactly: 100000)!)
//        detailMapView.setRegion(region, animated: true)
//    }
}
