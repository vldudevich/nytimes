//
//  FirstTabPresenter.swift
//  MyWeatherApp
//
//  Created by vladislav on 17.06.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class MainModulePresenter: MainModuleViewOutput {
    
    var view: MainModuleViewInput!
    
    let reviewsViewController = UIStoryboard(name: "ReviewModuleViewController", bundle: nil).instantiateInitialViewController()!
    let criticsViewController = UIStoryboard(name: "CriticModuleViewController", bundle: nil).instantiateInitialViewController()!
    
    func setupInitialState() {
        choseControllerForSelectedSegmentIndex(with: .reviewsViewControllerTab)
        view.setupState()
    }
    
    func choseControllerForSelectedSegmentIndex(with tabIndex: MainModuleViewController.TabIndex) {
        
        switch tabIndex {
        case .reviewsViewControllerTab:
            self.view.updateController(for: .reviewsViewControllerTab, viewController: reviewsViewController)
        case .criticsViewControllerTab:
            self.view.updateController(for: .criticsViewControllerTab, viewController: criticsViewController)
        }
    }
}
