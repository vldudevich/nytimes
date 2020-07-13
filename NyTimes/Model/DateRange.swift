//
//  DateRange.swift
//  NyTimes
//
//  Created by vladislav on 29.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

struct DateRange {
    let fromDate: String
    let toDate: String
    private var urlRepresentation: String {
        return "\(fromDate);\(toDate)"
    }
}
