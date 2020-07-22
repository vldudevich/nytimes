//
//  ReviewsTableViewCell.swift
//  NyTimes
//
//  Created by vladislav on 22.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol ReviewsTableViewCellDelegate {
    func shareButtonTouchUpInside(_ cell: ReviewsTableViewCell)
}

class ReviewsTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewTableViewCell"
    
    @IBOutlet private weak var reviewTitleLabel: UILabel!
    @IBOutlet private weak var reviewImageView: UIImageView!
    @IBOutlet private weak var reviewDescriptionLabel: UILabel!
    @IBOutlet private weak var reviewNameLabel: UILabel!
    @IBOutlet private weak var rewiewDateLabel: UILabel!
    @IBOutlet private weak var shareButton: UIButton!
    
    var delegate: ReviewsTableViewCellDelegate?
    
    @IBAction func shareClick(_ sender: Any) {
        delegate?.shareButtonTouchUpInside(self)
    }
    
    func configureCell(results: Movie) {
        reviewTitleLabel.text = results.displayTitle
        reviewDescriptionLabel.text = results.summaryShort
        reviewNameLabel.text = results.byline
        rewiewDateLabel.text = results.dateUpdated
        results.getImage { (image) in
            self.reviewImageView.image = image
        }
    }
}
