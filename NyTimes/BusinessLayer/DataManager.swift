//
//  DataManager.swift
//  NyTimes
//
//  Created by vladislav on 13.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    static let sharedManager = DataManager()
    
    func getMoviesData(cityToSearch: String, dateToSearch: DateRange, succes: @escaping (_ success: Review) -> Void) {
        API.sharedManager.reviews(stringToSearch: cityToSearch, dateToSearch: dateToSearch,  succes: { (data) in
            Review.parseResponse(responseData: data) { (review) in
                succes(review)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func getCriticsData(criticToSearch: String, _ succes: @escaping (_ success: Critic) -> Void) {
        API.sharedManager.critics(searchCriticName: criticToSearch, succes: { (data) in
            Critic.parseResponse(responseData: data) { (critic) in
                succes(critic)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func searchCriticsMovies(searchMovies: String, succes: @escaping (_ success: Review) -> Void) {
        API.sharedManager.searchCriticsMovies(searchMovies: searchMovies, succes: { (data) in
            Review.parseResponse(responseData: data) { (critic) in
                succes(critic)
            }
        }) { (error) in
            print(error)
        }
    }
}
