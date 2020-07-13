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
    
    @IBOutlet weak var criticsMoviesImageView: UIImageView!
    @IBOutlet weak var criticsMoviesTitleLabel: UILabel!
    @IBOutlet weak var criticsDescriptionLabel: UILabel!
    @IBOutlet weak var criticsNameMoviesLabel: UILabel!
    @IBOutlet weak var criticsMoviesDateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    private var cellDelegate: CriticsReviewsTableViewCellDelegate?
    
    @IBAction func shareTap(_ sender: Any) {
        cellDelegate?.shareButtonTouchUpInside(self)
    }
    
    func configureCell(results: [Movie], for indexPath: IndexPath) {
        criticsMoviesTitleLabel.text = results[indexPath.row].displayTitle
        criticsDescriptionLabel.text = results[indexPath.row].summaryShort
        criticsNameMoviesLabel.text = results[indexPath.row].byline
        criticsMoviesDateLabel.text = results[indexPath.row].dateUpdated
        results[indexPath.row].getImage { (image) in
            self.criticsMoviesImageView.image = image
        }
    }
}
