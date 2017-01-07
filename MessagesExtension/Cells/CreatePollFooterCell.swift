//
//  CreatePollFooterCell.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreatePollFooterCell: UICollectionViewCell {
    @IBOutlet weak var addOptionButton: UIButton!
    var createFooterAction: Variable<CreatePollAction>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addOptionButton.rx.tap.subscribe(onNext: {
            guard let createFooterAction = self.createFooterAction else {return}
            createFooterAction.value = CreatePollAction.AddOption
        }).addDisposableTo(rx_disposeBag)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
