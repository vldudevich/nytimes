//
//  CriticModulePresenter.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class CriticModulePresenter: CriticModuleViewOutput {
    
    weak var view: CriticModuleViewInput!
    
    func setupInitialState(criticToSearch: String) {
        getCriticsData(criticToSearch: criticToSearch)
        view.setupState()
    }
    
    private func getCriticsData(criticToSearch: String) {
        let dataManager = DataManager()
        dataManager.getCriticsData(criticToSearch: criticToSearch) { (critic) in
            self.view.onCriticsGet(results: critic)
        }
    }
    
}
