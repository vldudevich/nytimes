//
//  ReviewModuleInitializer.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class ReviewModuleInitializer: NSObject {
    
    @IBOutlet private var viewController: ReviewModuleViewController!
    
    override func awakeFromNib() {
        let configurator = ReviewModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
