//
//  MainModuleInitializer.swift
//  NyTimes
//
//  Created by vladislav on 30.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class MainModuleInitializer: NSObject {
    
    @IBOutlet var viewController: MainModuleViewController!
    
    override func awakeFromNib() {
        let configurator = MainModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
