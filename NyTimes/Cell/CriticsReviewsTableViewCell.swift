//
//  CriticsReviewsTableViewCell.swift
//  NyTimes
//
//  Created by vladislav on 31.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol CriticsReviewsTableViewCellDelegate {
    func shareButtonTouchUpInside(_ cell: CriticsReviewsTableViewCell)
}

class CriticsReviewsTableViewCell: UITableViewCell {
    
    static let identifier = "CriticsReviewsTableViewCell"
    
    @IBOutlet private weak var criticsMoviesImageView: UIImageView!
    @IBOutlet private weak var criticsMoviesTitleLabel: UILabel!
    @IBOutlet private weak var criticsDescriptionLabel: UILabel!
    @IBOutlet private weak var criticsNameMoviesLabel: UILabel!
    @IBOutlet private weak var criticsMoviesDateLabel: UILabel!
    @IBOutlet private weak var shareButton: UIButton!
    
    private var cellDelegate: CriticsReviewsTableViewCellDelegate?
    
    @IBAction func shareTap(_ sender: Any) {
        cellDelegate?.shareButtonTouchUpInside(self)
    }
    
    func configureCell(results: Movie) {
        criticsMoviesTitleLabel.text = results.displayTitle
        criticsDescriptionLabel.text = results.summaryShort
        criticsNameMoviesLabel.text = results.byline
        criticsMoviesDateLabel.text = results.dateUpdated
        results.getImage { (image) in
            self.criticsMoviesImageView.image = image
        }
    }
}
