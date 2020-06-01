//
//  Multimedia.swift
//  NyTimes
//
//  Created by vladislav on 26.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class Multimedia: Codable {

    var type: String
    var src: String
    var width: Int
    var height: Int

    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case src = "src"
        case width = "width"
        case height = "height"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type)
        self.src = try container.decode(String.self, forKey: .src)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
    }
}

