//
//  PollCell.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit

class PollCell: UICollectionViewCell {
    @IBOutlet weak var questionLabel: UILabel!

    var pollCellViewModel: PollCellViewModel? {
        didSet {
            if let pollCellViewModel = pollCellViewModel {
                questionLabel.text = pollCellViewModel.title
            }
        }
    }
    
    override func layoutSubviews() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.layer.shadowRadius = 4
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        

        
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
