//
//  PollsViewController.swift
//  Poll
//
//  Created by Eliel Gordon on 9/17/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol PollsViewControllerDelegate: class {
    func pollsViewControllerDidSelectAdd(_ controller: PollsViewController)
}

class PollsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let pollsViewModel = PollsViewModel()
    weak var delegate: PollsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        pollsViewModel
            .addPollTapSubject
            .asObservable()
            .subscribe(onNext: { _ in
                self.delegate?.pollsViewControllerDidSelectAdd(self)
        }).addDisposableTo(rx_disposeBag)
    }
    
    func setup() {
        collectionView.dataSource = nil
        collectionView.delegate = nil
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.collectionViewLayout = layout
        
        collectionView.register(
            PollCell.nib(),
            forCellWithReuseIdentifier: String(describing: PollCell.self)
        )
        
        collectionView.register(NewPollCell.nib(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: NewPollCell.self))
        
        collectionView.rx
            .setDelegate(self)
            .addDisposableTo(rx_disposeBag)
        
        pollsViewModel.pollSectionItems?
            .bindTo(collectionView
                .rx
                .items(dataSource: pollsViewModel.dataSource))
            .addDisposableTo(rx_disposeBag)
//        
//        collectionView.rx
//            .modelSelected(PollCellViewModel.self)
//            .subscribe(onNext: {
//                [unowned self] model in
//            self.delegate?.pollsViewControllerDidSelectAdd(self)
//        }).addDisposableTo(rx_disposeBag)
    }
}

extension PollsViewController: Presentable {}
extension PollsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 10, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 10, bottom: 15, right: 10)
    }
}

extension PollsViewController: StoryboardIdentifiable {}
