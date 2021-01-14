//
//  NetworkManager.swift
//  ChicagoRestaurants
//
//  Created by Westside Health Authority on 11/3/20.
//  Copyright © 2020 Westside Health Authority. All rights reserved.
//

import Foundation

enum NetworkManager {
    static func getRestaurants(completion: @escaping ([Result]) -> Void) {
        let url = URL(string: "https://api.adzuna.com/v1/api/jobs/us/search/1?app_id=19ddf2c1&app_key=c1a0305d1c99a2b09ee2216415523d4a&results_per_page=40&what_or=Retail%20Supermarket%20Restaurant%20&where=Brighton%20Park&distance=3&max_days_old=60&content-type=application/json")!
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let restaurants = try decoder.decode(Response.self, from: data)
                let jobs = restaurants.results
                DispatchQueue.main.async {
                    completion(jobs)
                }
            } catch {
                print(error)
                }
            } else {
            print(response ?? "No Response Object", error ?? "No Error Object")
            }
        }.resume()
    }
}
