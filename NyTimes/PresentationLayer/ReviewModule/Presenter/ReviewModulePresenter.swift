//
//  ReviewModulePresenter.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class ReviewModulePresenter: ReviewModuleViewOutput {

    weak var view: ReviewModuleViewInput!
    
    func setupInitialState(cityToSearch: String, dateToSearch: DateRange) {
        getMoviewsData(cityToSearch: cityToSearch, dateToSearch: dateToSearch)
        view.setupState()
    }
    
    private func getMoviewsData(cityToSearch: String, dateToSearch: DateRange) {
        DataManager.sharedManager.getMoviesData(cityToSearch: cityToSearch, dateToSearch: dateToSearch) { (review) in
            self.view.onMoviesGet(results: review)
        }
    }
}
