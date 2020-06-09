//
//  ReviewsTableViewCell.swift
//  NyTimes
//
//  Created by vladislav on 22.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol TableViewNew {
    func onClick(index: Int)
}

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    @IBOutlet weak var reviewNameLabel: UILabel!
    @IBOutlet weak var rewiewDateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    static let identifier = "ReviewTableViewCell"
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    @IBAction func shareClick(_ sender: Any) {
        cellDelegate?.onClick(index: (index?.row) ?? 0)
    }
}
