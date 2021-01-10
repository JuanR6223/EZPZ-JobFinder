//
//  SearchBarTestViewController.swift
//  JobFinder
//
//  Created by Student on 1/7/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class SearchBarTestViewController: UIViewController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
            print(text)
    }
}
