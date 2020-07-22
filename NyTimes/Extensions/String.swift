//
//  Extensions.swift
//  NyTimes
//
//  Created by vladislav on 01.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
