//
//  CriticModel.swift
//  NyTimes
//
//  Created by vladislav on 22.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//
import Foundation

class Critic: Codable {
    
    static func parseResponse( responseData: Data, completionHandler: (Critic) -> Void) {
        let decoder = JSONDecoder()
        do {
            let moviesResponse = try decoder.decode(Critic.self, from: responseData)
            print(moviesResponse)
            completionHandler(moviesResponse)
        } catch {
            print(error)
        }
    }
    
    var status: String
    var copyright: String
    var results: [Critics]
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decode(String.self, forKey: .status)
        self.copyright = try container.decode(String.self, forKey: .copyright)
        self.results = try container.decode([Critics].self, forKey: .results)
    }
    

}
