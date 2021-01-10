//
//  WalgreensJobsTableViewController.swift
//  JobFinder
//
//  Created by Westside Health Authority on 11/13/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import UIKit
import MapKit
import SafariServices

class WalgreensJobsTableViewController: UITableViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var walgreensMapView: MKMapView!
    @IBOutlet weak var jobsSearch: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var jobsAvailable: UILabel!
    
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var spanLabel: UILabel!
    @IBOutlet var walgreensTableView: UITableView!
    
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        walgreensTableView.separatorStyle = .none
        walgreensTableView.tableHeaderView = nil
        
        jobsSearch.layer.borderWidth = 2.0
        commentsButton.layer.borderWidth = 2.0
        commentsButton.layer.cornerRadius = 2.0

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //walgreensMapView.delegate = self
        walgreensMapView.showsUserLocation = true
        walgreensMapView.userLocation.title = "My Location"
    
        getNearbyLandmarks()
    }
    
    @IBAction func jobsSearchPressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://jobs.walgreens.com/locations")!)
        present(vc, animated: true)
    }
    
    @IBAction func zoomSlider(_ sender: UISlider) {
        let sliderValue = sender.value
        let sliderRound = (sliderValue*100).rounded()/100
        spanLabel.text = "\(String(sliderRound)) mi"
    }

    //Having issue displaying blue orb
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerToLocation(location: locations.last!)
    }

    func centerToLocation (location: CLLocation) {
        let regionRadius: CLLocationDistance = 4828.03 //meters
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        walgreensMapView.setRegion(coordinateRegion, animated: true)
    }

    //Add Nearby Walgreens Location Pin
    private func getNearbyLandmarks() {
            
           let request = MKLocalSearch.Request()
           request.naturalLanguageQuery = "Walgreens"
           let search = MKLocalSearch(request: request)
            
           search.start { (response, error) -> Void in
           if let response = response {
                let mapItems = response.mapItems
            //Annoates(Adds Description) to each pin. Counts the total number of pins and puts that number on 'jobsAvailable' Label
            
            for mapItem in mapItems {
                let jobAnnotation = MKPointAnnotation()
                jobAnnotation.coordinate = mapItem.placemark.coordinate
                self.walgreensMapView.addAnnotation(jobAnnotation)
            }
            self.jobsAvailable.text = String(mapItems.count)

                
    
                }
            }
        }
            
    
}

//extension WalgreensJobsTableViewController: MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
//
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
//
//            //Resize Image
//            let walgreensPinImage = UIImage(named: "WalgreensPin")
//            var size = CGSize(width: 50, height: 50)
//            UIGraphicsBeginImageContext(size)
//            walgreensPinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//
//            var resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//
//            //Customize Pin Images
//            if let title = annotation.title, title == "Walgreens" {
//                annotationView?.image = resizedImage
//            }else if let title = annotation.title, title == "My Location" {
//                size = CGSize(width: 30, height: 40)
//                let userPinImage = UIImage(named: "UserPin")
//                UIGraphicsBeginImageContext(size)
//                userPinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//
//                resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//                annotationView?.image = resizedImage
//            }
//        }
//        annotationView!.canShowCallout = true
//
//        return annotationView
//    }
//}

