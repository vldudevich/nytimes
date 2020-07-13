//
//  File.swift
//  NyTimes
//
//  Created by vladislav on 30.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class MainModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? MainModuleViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: MainModuleViewController) {
        let presenter = MainModulePresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
