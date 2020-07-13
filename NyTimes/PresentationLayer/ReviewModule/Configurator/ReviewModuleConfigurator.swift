//
//  ReviewModuleConfigurator.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class ReviewModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? ReviewModuleViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: ReviewModuleViewController) {
        let presenter = ReviewModulePresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
