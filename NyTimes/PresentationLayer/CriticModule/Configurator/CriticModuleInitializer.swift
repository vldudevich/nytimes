//
//  CriticModuleInitializer.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class CriticModuleInitializer: NSObject {
    @IBOutlet var viewController: CriticModuleViewController!
    
    override func awakeFromNib() {
        let configurator = CriticModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
