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
    
    var result: Result
    var isFavorite: Bool
    
    init(result: Result, favorite: Bool) {
        self.result = result
        self.isFavorite = favorite
    }
}
