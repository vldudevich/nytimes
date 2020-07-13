//
//  DetailReviewModuleConigurator.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class DetailReviewModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? DetailReviewModuleViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: DetailReviewModuleViewController) {
        let presenter = DetailReviewModulePresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
