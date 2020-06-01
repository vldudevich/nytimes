//
//  ReviewsTableViewCell.swift
//  NyTimes
//
//  Created by vladislav on 22.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    @IBOutlet weak var reviewNameLabel: UILabel!
    @IBOutlet weak var rewiewDateLabel: UILabel!
    
    static let identifier = "ReviewTableViewCell"
}

