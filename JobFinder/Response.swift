//
//  Response.swift
//  ChicagoRestaurants
//
//  Created by Westside Health Authority on 11/3/20.
//  Copyright © 2020 Westside Health Authority. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let latitude: Double?
    let longitude: Double?
    let created: String
    //let label: String
    let redirectUrl: String
    let title: String
    let id: String
    let company: Company
    let location: Location
    let description: String
    //let salaryMin: String
    //let salaryMax: String
    let salaryIsPredicted: String
    //var isFavorite = false
    struct Company: Decodable {
        let displayName: String
    }
    
    struct Location: Decodable {
        let displayName: String
        //let location: String
    }
}

