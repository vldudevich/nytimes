//
//  Link.swift
//  NyTimes
//
//  Created by vladislav on 26.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class Link: Codable {
    
    var type: String
    var url: String
    var suggestedLink: String

    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
        case suggestedLink = "suggested_link_text"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode(String.self, forKey: .url)
        self.suggestedLink = try container.decode(String.self, forKey: .suggestedLink)
    }
}
