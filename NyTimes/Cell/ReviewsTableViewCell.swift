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
    
    static let identifier = "ReviewTableViewCell"
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    @IBOutlet weak var reviewNameLabel: UILabel!
    @IBOutlet weak var rewiewDateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    @IBAction func shareClick(_ sender: Any) {
        cellDelegate?.onClick(index: (index?.row) ?? 0)
    }
    
    func configureCell(results: [Movie], for indexPath: IndexPath) {
        
        reviewTitleLabel.text = results[indexPath.row].displayTitle
        reviewDescriptionLabel.text = results[indexPath.row].summaryShort
        reviewNameLabel.text = results[indexPath.row].byline
        rewiewDateLabel.text = results[indexPath.row].dateUpdated

        if let multimedia = results[indexPath.row].multimedia,
            let source = multimedia.sourceURL,
            let url = URL(string: source) {
            reviewImageView.af.setImage(withURL: url)
        } else {
            reviewImageView.image = UIImage(named: "nophoto")
        }
    }
}
