//
//  NewPollCell.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewPollCell: UICollectionViewCell {

    @IBOutlet weak var addPollButton: UIButton!
    var tapSubject: PublishSubject<Void>? = nil
    var tappable: Tappable? {
        didSet {
            guard let tappable = tappable else {
                return
            }
            addPollButton.rx.tap.bindTo(tappable.tapSubject).addDisposableTo(rx_disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addPressed(_ sender: AnyObject) {
        guard let tapSubject = tapSubject else {
            return
        }
        
        tapSubject.onNext(())
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
