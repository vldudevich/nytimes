//
//  Critics.swift
//  NyTimes
//
//  Created by vladislav on 27.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

class Critics: Codable {
    
    var displayName: String
    var sortName: String
    var status: String?
    var bio: String?
    var seoName: String
    var multimedia: Multi?
    
    private enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case sortName = "sort_name"
        case status = "status"
        case bio = "bio"
        case seoName = "seo_name"
        case multimedia
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.sortName = try container.decode(String.self, forKey: .sortName)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)?.htmlDecoded
        self.seoName = try container.decode(String.self, forKey: .seoName)
        self.multimedia = try container.decodeIfPresent(Multi.self, forKey: .multimedia)
    }
    
    func getImage(succes: @escaping (_ success: UIImage) -> Void)  {
        if let multimedia = multimedia,
            let source = multimedia.resource?.sourceURL,
            let url = URL(string: source) {
            Utils.load(url: url) { (data) in
                guard let image = data else {return}
                succes(image)
            }
        } else {
            succes(UIImage(named: "nophoto")!)
        }
    }
}
