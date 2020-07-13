//
//  DetailReviewModuleInput.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol DetailReviewModuleViewInput: AnyObject {
    func setupState()
    func onMoviesGet(results: Review)
}
