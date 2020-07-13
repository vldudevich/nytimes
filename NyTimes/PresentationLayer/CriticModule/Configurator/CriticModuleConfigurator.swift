//
//  CriticModuleConfigurator.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class CriticModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? CriticModuleViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: CriticModuleViewController) {
        let presenter = CriticModulePresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
