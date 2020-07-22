//
//  URLComponents.swift
//  NyTimes
//
//  Created by vladislav on 20.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

extension URLComponents {
        mutating func setQueryItems(with parameters: [String: Any]) {
            self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
    }
}
