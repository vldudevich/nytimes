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
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    @IBOutlet weak var reviewNameLabel: UILabel!
    @IBOutlet weak var rewiewDateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var delegate: ReviewsTableViewCellDelegate?
    
    @IBAction func shareClick(_ sender: Any) {
        delegate?.shareButtonTouchUpInside(self)
    }
    
    func configureCell(results: [Movie], for indexPath: IndexPath) {
        if results.count != 0 {
            reviewTitleLabel.text = results[indexPath.row].displayTitle
            reviewDescriptionLabel.text = results[indexPath.row].summaryShort
            reviewNameLabel.text = results[indexPath.row].byline
            rewiewDateLabel.text = results[indexPath.row].dateUpdated
            results[indexPath.row].getImage { (image) in
                self.reviewImageView.image = image
            }
        }
    }
}
