//
//  Api.swift
//  NyTimes
//
//  Created by vladislav on 22.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    typealias CompletionBlock = (_ success: Data) -> Void
    typealias ErrorBlock = (_ error: Any) -> Void
    typealias ImageBlock = (_ success: UIImage) -> Void
    
    static let sharedManager = API()
    
    func request(for url: String, paramsDict: [String: Any]) -> DataRequest? {
        guard let reviewURL = URL(string: APIConstant.baseURL.rawValue + url) else {
            return nil
        }
        var parameters: Parameters = [
            APIConstant.apiKey.rawValue: APIConstant.apiKeyValue.rawValue,
        ]
        parameters.merge(paramsDict) { (value1, value2) -> Any in
            return value1
        }
        
        return AF.request(reviewURL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: nil)
    }
    
    func reviews(stringToSearch: String, dateToSearch: DateRange, succes: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        if let request = self.request(for: APIConstant.reviewsURL.rawValue, paramsDict:["query":stringToSearch,
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
    
    func critics(searchCriticName: String, succes: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        
        var url = APIConstant.criticssURL.rawValue
        
        if searchCriticName != "" {
            url = APIConstant.criticsURL.rawValue + searchCriticName
        }else {
            url = APIConstant.criticsURL.rawValue + "all"
        }
        url = url + ".json"
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
    
    func searchCriticsMovies(searchMovies: String, succes: @escaping CompletionBlock, failure: @escaping ErrorBlock) {
        let encodeString = searchMovies.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let request = self.request(for: APIConstant.reviewsMoviesURL.rawValue + encodeString! + ".json", paramsDict: [:]) {
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
