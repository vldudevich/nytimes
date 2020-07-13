//
//  CriticsCollectionViewCell.swift
//  NyTimes
//
//  Created by vladislav on 26.05.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class CriticsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var criticsImageView: UIImageView!
    @IBOutlet weak var criticsNameLabel: UILabel!
    
    static let identifier = "CriticsCollectionViewCell"
    
    func configureCell(results: [Critics], for indexPath: IndexPath) {
        if results.count != 0 {
            criticsNameLabel.text = results[indexPath.row].displayName
            results[indexPath.row].getImage { (image) in
                self.criticsImageView.image = image
            }
        }
    }
}
