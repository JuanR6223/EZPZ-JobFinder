//
//  Jobs.swift
//  JobFinder
//
//  Created by Westside Health Authority on 11/18/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class JobClass {
    
    var image: UIImage
    var title: String
    
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
}

struct JobsList {
    
    static let job1 = UIImage(named: "Walgreens")
    //static let job2 = UIImage(named: "Aldi")
    static let job3 = UIImage(named: "Walmart")
    static let job4 = UIImage(named: "Potbelly")
    static let job5 = UIImage(named: "Shell Oil")
    static let job6 = UIImage(named: "Coca Cola")
    static let job7 = UIImage(named: "Denny's")

}
