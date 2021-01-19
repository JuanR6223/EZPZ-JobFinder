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
    @IBOutlet weak var learnMoreButton: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    
    var job: Result?
    var annotations = [MKPointAnnotation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAddressFromLocation()
        
        detailMapView.delegate = self
        
        companyNameLabel.attributedText = convertHTMLText(text: job!.company.displayName, attritbutedText: &(companyNameLabel.attributedText)!)
        companyNameLabel.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 24.0)
        companyNameLabel.textAlignment = .center
        
        jobTitleLabel.attributedText = convertHTMLText(text: job!.title, attritbutedText: &(jobTitleLabel.attributedText)!)
        jobTitleLabel.font = UIFont(name: "Avenir Next Regular", size: 16.0)

        descriptionLabel.attributedText = convertHTMLText(text: job!.description, attritbutedText: &(descriptionLabel.attributedText)!)
        descriptionLabel.font = UIFont(name: "Avenir Next Regular", size: 16.0)
        
        jobCreatedLabel.text = job?.created
        jobCreatedLabel.attributedText = convertHTMLText(text: job!.created, attritbutedText: &(jobCreatedLabel.attributedText)!)
        jobCreatedLabel.font = UIFont(name: "Avenir Next Regular", size: 16.0)
        
        jobLabelLabel.attributedText = convertHTMLText(text: job!.location.displayName, attritbutedText: &(jobLabelLabel.attributedText)!)
        jobLabelLabel.font = UIFont(name: "Avenir Next Regular", size: 16.0)
        
        learnMoreButton.text = "Apply to Learn More"
        
        applyButton.layer.cornerRadius = 5
        
        detailMapView.showsUserLocation = true
        detailMapView.userLocation.title = "My Location"
        
        self.detailMapView.showAnnotations(annotations, animated: false)
        
        let region = MKCoordinateRegion( center: detailMapView.userLocation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)
        detailMapView.setRegion(region, animated: true)
        
        jobsTableView.reloadData()
    }
    
    @IBAction func linkPressed(_ sender: Any) {
        let link = job?.redirectUrl
        let vc = SFSafariViewController(url: URL(string: link!)!)
        present(vc, animated: true)
    }
    
    func GetAddressFromLocation() {
        let ceo: CLGeocoder = CLGeocoder()
        var addressString : String = ""
        
        if let latitude = job?.latitude, let longitude = job?.longitude {
            let loc: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            
            ceo.reverseGeocodeLocation(loc, completionHandler: { [self](placemarks, error) in
                if (error != nil) {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                let pm = placemarks![0]
//                print(pm.country!)
//                print(pm.locality!)
//                print(pm.subLocality!)
//                print(pm.thoroughfare!)
//                print(pm.postalCode!)
//                print(pm.subThoroughfare!)
//                print(pm.administrativeArea)
                
                if pm.subThoroughfare != nil {
                    addressString = addressString + pm.subThoroughfare! + " "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if let state = pm.administrativeArea {
                    addressString.append(state + ", ")
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                annotation.title = job?.company.displayName
                annotation.subtitle = addressString
            })
            annotations.append(annotation)
        }
    }
    
    func convertHTMLText(text: String, attritbutedText: inout NSAttributedString) -> NSAttributedString {
        let data = Data(text.utf8)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue]
        
        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            attritbutedText = attributedString
            return attributedString
        }
        return attritbutedText
    }
}

