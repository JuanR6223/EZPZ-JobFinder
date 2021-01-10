//
//  OrganizationsCollectionViewCell.swift
//  JobFinder
//
//  Created by Westside Health Authority on 11/25/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class OrganizationsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var organizationImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
              
        addSubview(organizationImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       }
    
    func setContentView(organizations: OrganizationClass) {
        
        organizationImageView.image = organizations.Orgimage
    }
}
