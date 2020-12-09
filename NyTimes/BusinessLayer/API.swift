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
    
    func request(for path: String, paramsDict: [String: Any]) -> DataRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APIConstant.baseURL.rawValue
        urlComponents.path = path
        urlComponents.setQueryItems(with: paramsDict)
        urlComponents.queryItems?.append(URLQueryItem(name: APIConstant.apiKey.rawValue, value: APIConstant.apiKeyValue.rawValue))
    
        guard let resultUrl = urlComponents.url else { return nil }
        return AF.request(resultUrl, method: .get, encoding: URLEncoding(destination: .queryString), headers: nil)
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
        
        var url: String
        
        if searchCriticName != "" {
            url = APIConstant.criticsURL.rawValue + searchCriticName + ".json"
        }else {
            url = APIConstant.criticssURL.rawValue
        }

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
        if let request = self.request(for: APIConstant.reviewsMoviesURL.rawValue + searchMovies + ".json", paramsDict: [:]) {
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
    
    func parseResponse<T: Codable>(responseData: Data, completionHandler: (T) -> Void) {
        let decoder = JSONDecoder()
        do {
            let moviesResponse = try decoder.decode(T.self, from: responseData)
            print(moviesResponse)
            completionHandler(moviesResponse)
        } catch {
            print(error)
        }
    }
    
}
