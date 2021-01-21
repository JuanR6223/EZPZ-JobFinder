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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var favoriteTitle: UILabel!
    @IBOutlet weak var noFavoriteLabel: UILabel!
    
    var jobPosts = [JobClass]()
    
    //Array of Company Display Names
    var dataToDisplay = [JobClass]()
    
    //favoritesListData
    var favoritesList = [JobClass]()
    
    //var memberAnnotations: [JobPointAnnotation]?
    var memberAnnotations: [MKAnnotation]?
    var locationManager = CLLocationManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerAnnotationViewClasses()
        
        mapView.showsUserLocation = true
        mapView.userLocation.title = "My Location"
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        search.delegate = self
        search.placeholder = "Type something here to search for jobs"
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        NetworkManager.getRestaurants { [self] (restaurants) in
            //self.jobPosts = restaurants
            for result in restaurants {
                let job = JobClass(result: result, favorite: false)
                self.jobPosts.append(job)
            }
            //var annotations = [JobPointAnnotation]()
            var annotations = [MKPointAnnotation]()
            for post in self.jobPosts {
                if let latitude = post.result.latitude, let longitude = post.result.longitude {
                    //let annotation = JobPointAnnotation()
                    let annotation = MKPointAnnotation()
                    annotation.title = post.result.company.displayName
                    annotation.subtitle = post.result.title
                    //annotation.job = post
                    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    annotations.append(annotation)
                }
            }
            self.dataToDisplay = self.jobPosts
            self.mapView.showAnnotations(annotations, animated: false)
            self.tableView.reloadData()
        }
    }
    
    //Segmented Control
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            mapView.isHidden = false
            tableView.isHidden = true
            search.isHidden = true
            favoriteTitle.isHidden = true
        } else if sender.selectedSegmentIndex == 2{
            mapView.isHidden = true
            tableView.isHidden = false
            search.isHidden = true
            tableView.frame.origin = CGPoint(x: 0, y: 144)
            favoriteTitle.isHidden = false
            favoriteTitle.frame.origin = CGPoint(x: 0, y: 88)
            
            dataToDisplay = favoritesList
            updateFavorites()
        } else {
            mapView.isHidden = true
            tableView.isHidden = false
            tableView.frame.origin = CGPoint(x: 0, y: 144)
            search.isHidden = false
            favoriteTitle.isHidden = true
            
            dataToDisplay = self.jobPosts
            updateFavorites()
            tableView.reloadData()
        }
    }

    
    //MapView
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let annotationView = view.annotation as? MKClusterAnnotation {
            print(annotationView.memberAnnotations.count)
            memberAnnotations = annotationView.memberAnnotations
            
            performSegue(withIdentifier: "clusterSegue", sender: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerToLocation(location: locations.last!)
    }
    
    func centerToLocation (location: CLLocation) {
        let regionRadius: CLLocationDistance = 4828.03 //meters
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
//    func GetAddressFromLocation() {
//        let ceo: CLGeocoder = CLGeocoder()
//        var addressString : String = ""
//
//        if let latitude = jobPosts.result.latitude, let longitude = jobPosts?.result.longitude {
//            let loc: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
//            let annotation = MKPointAnnotation()
//
//            ceo.reverseGeocodeLocation(loc, completionHandler: { [self](placemarks, error) in
//                if (error != nil) {
//                    print("reverse geodcode fail: \(error!.localizedDescription)")
//                }
//
//                let pm = placemarks![0]
//
//                if pm.subThoroughfare != nil {
//                    addressString = addressString + pm.subThoroughfare! + " "
//                }
//                if pm.thoroughfare != nil {
//                    addressString = addressString + pm.thoroughfare! + ", "
//                }
//                if pm.locality != nil {
//                    addressString = addressString + pm.locality! + ", "
//                }
//                if let state = pm.administrativeArea {
//                    addressString.append(state + ", ")
//                }
//                if pm.country != nil {
//                    addressString = addressString + pm.country! + ", "
//                }
//                if pm.postalCode != nil {
//                    addressString = addressString + pm.postalCode! + " "
//                }
//                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//                annotation.title = .
//                annotation.subtitle = addressString
//            })
//            annotations.append(annotation)
//        }
//    }
    
    //JobsTableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        let job = dataToDisplay[indexPath.row].result
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "HH:mm E, d MMM y"
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = job.company.displayName
        cell.textLabel?.font = UIFont(name: "Avenir Next SemiBold", size: 18.0)
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.attributedText = convertHTMLText(text: "\(job.title) ")
        cell.detailTextLabel?.font = UIFont(name: "Avenir Next Regular", size: 12.0)
        
        //cell.dateCreated.text = String(describing: formatter4.date(from: job.created))
        cell.dateCreated.text = job.created

        cell.dateCreated.font = UIFont(name: "Avenir Next Regular", size: 12.0)

        // assign the index of the youtuber to button tag
          cell.favoriteButton.tag = indexPath.row
          
          // call the subscribeTapped method when tapped
          cell.favoriteButton.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
        
        if dataToDisplay[indexPath.row].isFavorite {
            cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
            
        return cell
    }
    
    @objc func favoriteTapped(_ sender: UIButton){
        let job = jobPosts[sender.tag]
        job.isFavorite = !job.isFavorite
        updateFavorites()
    }
    
    func updateFavorites() {
        favoritesList.removeAll()
        for jobPost in jobPosts {
            if jobPost.isFavorite {
                favoritesList.append(jobPost)
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "jobsSegue", sender: self)
    }
    
    
    //Segue Data
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
                destination.job = dataToDisplay[indexPath.row]
            }
        }
    }
    
    //SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            dataToDisplay = jobPosts
        } else {
            dataToDisplay.removeAll()
            for job in jobPosts {
                if job.result.title.lowercased().contains(searchText.lowercased()) || job.result.company.displayName.lowercased().contains(searchText.lowercased()) {
                    dataToDisplay.append(job)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
