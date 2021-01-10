//
//  OrganizationClass.swift
//  JobFinder
//
//  Created by Westside Health Authority on 11/25/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class OrganizationClass {
    
    var Orgimage: UIImage
    
    init(image: UIImage, title: String) {
        self.Orgimage = image
    }
}

struct OrganizationsList {
    
    
    static let org1 = UIImage(named: "AfterSchoolMatters")
    static let org2 = UIImage(named: "CatholicCharities")
    static let org3 = UIImage(named: "JobCorps" )
    static let org4 = UIImage(named: "AdlerPlanetarium")
    static let org5 = UIImage(named: "AlternativeInc")
    static let org6 = UIImage(named: "ChicagoYouthCenters")
    static let org7 = UIImage(named: "AmeriCorps")
    static let org8 = UIImage(named: "ChicagoYouthProgramsInc")
    
}

//struct VolunteerList {
//    
//    static let vol1 = UIImage(named: "AfterSchoolMatters")
//    static let vol2 = UIImage(named: "CatholicCharities")
//}
