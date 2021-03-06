//
//  ReviewModuleViewInput.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

protocol ReviewModuleViewInput: AnyObject {
    func setupState()
    func onMoviesGet(results: Review)
}
