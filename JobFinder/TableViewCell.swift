//
//  TableViewCell.swift
//  JobFinder
//
//  Created by Student on 1/16/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var favoriteButton = UIButton(type: .system)
    var dateCreated: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        dateCreated = UILabel(frame: CGRect(x: 20, y: 64, width: 200, height: 14))
        dateCreated.textColor = .black
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        favoriteButton.tintColor = .orange
        accessoryView = favoriteButton
                
        addSubview(dateCreated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
