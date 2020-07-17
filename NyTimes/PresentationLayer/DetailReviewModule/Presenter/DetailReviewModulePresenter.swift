//
//  DetailReviewModulePresenter.swift
//  NyTimes
//
//  Created by vladislav on 01.07.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class DetailReviewModulePresenter: DetailReviewModuleViewOutput {
    weak var view: DetailReviewModuleViewInput!
    
    func setupInitialState(searchMovies: String) {
        getMoviewsData(searchMovies: searchMovies)
        view.setupState()
    }
    
    private func getMoviewsData(searchMovies: String) {
        let dataManager = DataManager()
        dataManager.searchCriticsMovies(searchMovies: searchMovies) { (critic) in
            self.view.onMoviesGet(results: critic)
        }
    }

}
