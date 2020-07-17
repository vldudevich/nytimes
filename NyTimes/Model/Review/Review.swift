//
//  MovieModel.swift
//  NyTimes
//
//  Created by vladislav on 22.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class Review: Codable {
    
    var status: String
    var copyright: String
    var hasMore: Bool
    var numberResult: Int
    var results: [Movie]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case hasMore = "has_more"
        case numberResult = "num_results"
        case results = "results"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decode(String.self, forKey: .status)
        self.copyright = try container.decode(String.self, forKey: .copyright)
        self.hasMore = try container.decode(Bool.self, forKey: .hasMore)
        self.numberResult = try container.decode(Int.self, forKey: .numberResult)
        self.results = try container.decode([Movie].self, forKey: .results)
    }
}
