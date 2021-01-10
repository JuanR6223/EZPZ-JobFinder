//
//  Main_Screen.swift
//  JobFinder
//
//  Created by Apple on 7/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class MainJobsPage: UIViewController, UITextFieldDelegate, UISearchBarDelegate {

    @IBOutlet weak var interestLogo: UILabel!
    @IBOutlet weak var jobsCollectionView: UICollectionView!
    
    var jobs: [JobClass] = []
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        
        jobs = fetchData()
        
        jobsCollectionView.delegate = self
        jobsCollectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        jobsCollectionView!.collectionViewLayout = layout
    }
}


extension MainJobsPage: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        print("tapped")
        }
    }


extension MainJobsPage: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobsCell", for: indexPath) as! JobsCollectionViewCell
        let job = jobs[indexPath.row]
        cell.setContentView(jobs: job)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return jobs.count
    }
}


extension MainJobsPage: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 392, height: 180)
    }
}


extension MainJobsPage {
    
    func fetchData() -> [JobClass] {
        let Job1 = JobClass(image: JobsList.job1!, title: "Walgreens")
        //let Job2 = JobClass(image: JobsList.job2!, title: "Aldi")
        let Job3 = JobClass(image: JobsList.job3!, title: "Walmart")
        let Job4 = JobClass(image: JobsList.job4!, title: "Potbelly")
        let Job5 = JobClass(image: JobsList.job5!, title: "Shell Oil")
        let Job6 = JobClass(image: JobsList.job6!, title: "Coca Cola")
        let Job7 = JobClass(image: JobsList.job7!, title: "Denny's")

        return [Job1, Job3, Job4, Job5, Job6, Job7]
    }
}
   
//-8,114 
