//
//  TableViewCell.swift
//  JobFinder
//
//  Created by Student on 1/16/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var favorite = false
    var favoriteButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favoriteButton.tintColor = .orange
        accessoryView = favoriteButton
        
        favoriteButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
    }
    
    @objc private func handleMarkAsFavorite() {
        
        if favorite == false {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            print("mark as favorite")

            favorite = !favorite
        } else if favorite == true {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            print("not favorite")

            favorite = !favorite
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
