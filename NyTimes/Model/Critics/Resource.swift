//
//  Resource.swift
//  NyTimes
//
//  Created by vladislav on 27.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class Resource: Codable {
    
    var type: String
    var sourceURL: String
    var width: Int
    var height: Int
    var credit: String

    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case sourceURL = "src"
        case width = "width"
        case height = "height"
        case credit = "credit"
    }
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(String.self, forKey: .type)
        self.sourceURL = try container.decode(String.self, forKey: .sourceURL)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.credit = try container.decode(String.self, forKey: .credit)
    }
}
