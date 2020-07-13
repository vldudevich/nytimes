//
//  MainModuleViewOutput.swift
//  NyTimes
//
//  Created by vladislav on 30.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol MainModuleViewOutput {
    func choseControllerForSelectedSegmentIndex(with tabIndex: MainModuleViewController.TabIndex)
    func setupInitialState()
}
