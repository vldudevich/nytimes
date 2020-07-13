//
//  DetailReviewModuleInitializer.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class DetailReviewModuleInitializer: NSObject {
    @IBOutlet var viewController: DetailReviewModuleViewController!
    
    override func awakeFromNib() {
        let configurator = DetailReviewModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
