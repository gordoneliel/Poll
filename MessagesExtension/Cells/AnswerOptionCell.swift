//
//  AnswerOptionCell.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit

class AnswerOptionCell: UICollectionViewCell {

    @IBOutlet weak var answerOptionField: UITextField!
    var answerOptionCellViewModel: AnswerOptionCellViewModel? {
        didSet {
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
