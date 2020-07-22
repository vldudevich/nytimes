//
//  CriticsCollectionViewCell.swift
//  NyTimes
//
//  Created by vladislav on 26.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class CriticsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var criticsImageView: UIImageView!
    @IBOutlet private weak var criticsNameLabel: UILabel!
    
    static let identifier = "CriticsCollectionViewCell"
    
    func configureCell(results: Critics) {
        criticsNameLabel.text = results.displayName
        results.getImage { (image) in
            self.criticsImageView.image = image
        }
    }
}
