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
    
    func getMoviesData(cityToSearch: String, dateToSearch: DateRange, succes: @escaping (_ success: Review) -> Void) {
        let api = API()
        api.reviews(stringToSearch: cityToSearch, dateToSearch: dateToSearch,  succes: { (data) in
            api.parseResponse(responseData: data) { (review) in
                succes(review)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func getCriticsData(criticToSearch: String, succes: @escaping (_ success: Critic) -> Void) {
        let api = API()
        api.critics(searchCriticName: criticToSearch, succes: { (data) in
            api.parseResponse(responseData: data) { (critic) in
                succes(critic)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func searchCriticsMovies(searchMovies: String, succes: @escaping (_ success: Review) -> Void) {
        let api = API()
        api.searchCriticsMovies(searchMovies: searchMovies, succes: { (data) in
            api.parseResponse(responseData: data) { (critic) in
                succes(critic)
            }
        }) { (error) in
            print(error)
        }
    }
}
