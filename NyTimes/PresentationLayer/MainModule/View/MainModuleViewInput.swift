//
//  MainModuleViewInput.swift
//  NyTimes
//
//  Created by vladislav on 30.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol MainModuleViewInput: AnyObject {
    func setupState()
    func updateController(for segmentedIndex: MainModuleViewController.TabIndex, viewController: UIViewController)
}
