//
//  QuestionCell.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {

    @IBOutlet weak var questionField: UITextField!
    var questionCellViewModel: QuestionCellViewModel? {
        didSet {
            guard let questionCellViewModel = questionCellViewModel else {
                return
            }
            
            questionField.placeholder = questionCellViewModel.content.value
            questionField.rx.text
                .do(onNext:  { text in
                    
                })
                .bindTo(questionCellViewModel.content)
                .addDisposableTo(rx_disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
