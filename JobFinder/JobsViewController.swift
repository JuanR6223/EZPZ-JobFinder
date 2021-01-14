//
//  RestaurantsTableViewController.swift
//  ChicagoRestaurants
//
//  Created by Westside Health Authority on 11/3/20.
//  Copyright © 2020 Westside Health Authority. All rights reserved.
//

import UIKit
import MapKit

class JobsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var jobPosts = [Result]()
    var memberAnnotations: [MKAnnotation]?
    var locationManager = CLLocationManager()
    
    //Array of Company Display Names
    var data = [String]()
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAnnotationViewClasses()
        
        search.delegate = self
        search.placeholder = "Type something here to search for jobs"

        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        NetworkManager.getRestaurants { [self] (restaurants) in
            self.jobPosts = restaurants
            var annotations = [MKPointAnnotation]()
            
            for post in self.jobPosts {
                if let latitude = post.latitude, let longitude = post.longitude {
                    let annotation = MKPointAnnotation()
                    annotation.title = post.company.displayName
                    annotation.subtitle = post.title
                    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    annotations.append(annotation)
                    data.append(annotation.title!)
                }
            }
            filteredData = data
            self.mapView.showAnnotations(annotations, animated: false)
            self.tableView.reloadData()
        }
        
        mapView.showsUserLocation = true
        mapView.userLocation.title = "My Location"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Table view data source
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            mapView.isHidden = false
            tableView.isHidden = true
            search.isHidden = true
        } else {
            mapView.isHidden = true
            tableView.isHidden = false
            search.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let restaurant = jobPosts[indexPath.row]
        //cell.textLabel?.text = restaurant.company.displayName
        cell.textLabel?.text = filteredData[indexPath.row]
        
        cell.detailTextLabel?.text = restaurant.title
        
        return cell
    }
    
    
    private func registerAnnotationViewClasses() {
        mapView.register(JobMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let annotationView = JobMarkerAnnotationView(annotation: annotation, reuseIdentifier: JobMarkerAnnotationView.ReuseID)
        
        if annotationView != nil {
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            //btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        } else {
            annotationView.annotation = annotation
        }
        return annotationView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerToLocation(location: locations.last!)
    }
    
    func centerToLocation (location: CLLocation) {
        let regionRadius: CLLocationDistance = 4828.03 //meters
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? ClusterDetailTableViewController {
            if let memberAnnotations = memberAnnotations {
                dvc.memberAnnotations = memberAnnotations
            }
        } else {
            // Get the new view controller using segue.destination.
            let destination = segue.destination as! BusinessTableViewController
            // Pass the selected object to the new view controller.
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.job = jobPosts[indexPath.row]
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let annotationView = view.annotation as? MKClusterAnnotation {
            print(annotationView.memberAnnotations.count)
            memberAnnotations = annotationView.memberAnnotations
            
            performSegue(withIdentifier: "clusterSegue", sender: nil)
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("hi")
        
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        } else {
            for jobTitle in data {
                if jobTitle.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(jobTitle)
                }
            }
        }
        self.tableView.reloadData()
    }
}
