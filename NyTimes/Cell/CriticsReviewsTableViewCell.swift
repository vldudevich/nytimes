//
//  CriticsReviewsTableViewCell.swift
//  NyTimes
//
//  Created by vladislav on 31.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class CriticsReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var criticsMoviesImageView: UIImageView!
    @IBOutlet weak var criticsMoviesTitleLabel: UILabel!
    @IBOutlet weak var criticsDescriptionLabel: UILabel!
    @IBOutlet weak var criticsNameMoviesLabel: UILabel!
    @IBOutlet weak var criticsMoviesDateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    static let identifier = "CriticsReviewsTableViewCell"
}
