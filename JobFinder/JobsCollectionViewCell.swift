//
//  JobsCollectionViewCell.swift
//  JobFinder
//
//  Created by Westside Health Authority on 11/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class JobsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var jobsImageView: UIImageView!
    @IBOutlet weak var jobsTitleButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
              
        addSubview(jobsImageView)
    }
    
   required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    }
    
    func setContentView(jobs: JobClass) {
           
           jobsImageView.image = jobs.image
           jobsTitleButton.setTitle(jobs.title, for: .normal)
       }
}
