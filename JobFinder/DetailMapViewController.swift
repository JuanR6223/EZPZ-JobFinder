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
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerToLocation(location: locations.last!)
    }

    func centerToLocation (location: CLLocation) {
        let regionRadius: CLLocationDistance = 4828.03 //meters
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        detailMapView.setRegion(coordinateRegion, animated: true)
    }
    
}
