//
//  Api.swift
//  NyTimes
//
//  Created by vladislav on 22.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//
//singleton
import Foundation
import Alamofire

class API {

    typealias CompletionBlock = (_ success: Data) -> Void
    typealias ErrorBlock = (_ error: Any) -> Void
    typealias ImageBlock = (_ success: UIImage) -> Void
    static let apiKey = "api-key"
    static let apiKeyValue  = "cGDuolttixJXxCmkFDeTTNnOA5EOidPt"
    static let baseURL = "https://api.nytimes.com/svc/movies/v2/"
    static let reviewsURL = "reviews/search.json"
    static let criticssURL = "critics/all.json"
    static let reviewsMoviesURL = "reviews/"
    static let criticsURL = "critics/"
    static let endURL = ".json"


   static func request(for url: String, paramsDict: [String: Any]) -> DataRequest? {
       guard let reviewURL = URL(string: baseURL + url) else {
           return nil
       }
       var parameters: Parameters = [
           apiKey: apiKeyValue,
       ]
       parameters.merge(paramsDict) { (value1, value2) -> Any in
           return value1
       }

    return AF.request(reviewURL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil)
   }
    
    static func reviews(stringToSearch: String, dateToSearch: DateRange, succes: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        if let request = self.request(for: self.reviewsURL, paramsDict:["query":stringToSearch,
                                                                        "opening_date":dateToSearch]) {
            request.response(completionHandler: { (response) in
                if let realData = response.data {
                    print("success recieve reviews/search")
                    succes(realData)
                } else {
                    failure("No data")
                }
            })
        } else {
            failure("Request create unsuccessfull")
        }
        
    }
    
    static func critics(searchCriticName: String, succes: @escaping CompletionBlock, failure: @escaping ErrorBlock) {

        var url = self.criticsURL
        
        if searchCriticName != "" {
            url = self.criticsURL + searchCriticName
        }else {
            url = self.criticsURL + "all"
        }
        url = url + endURL
        if let request = self.request(for: url, paramsDict: [:]) {
            request.response(completionHandler: { (response) in
                if let realData = response.data {
                    print("success recieve critics")
                    succes(realData)
                } else {
                    failure("No data")
                }
            })
        } else {
            failure("Request create unsuccessfull")
        }
    }
    
    static func searchCriticsMovies(searchMovies: String, succes: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        let encodeString = searchMovies.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let request = self.request(for: reviewsMoviesURL + encodeString! + ".json", paramsDict: [:]) {
            request.response(completionHandler: { (response) in
                if let realData = response.data {
                    print("success recieve critics movies")
                    succes(realData)
                } else {
                    failure("No data")
                }
            })
        } else {
            failure("Request create unsuccessfull")
        }
    }
    
}
