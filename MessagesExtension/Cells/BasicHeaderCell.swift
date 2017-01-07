//
//  BasicHeaderCell.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit

class BasicHeaderCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
