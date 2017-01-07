//
//  CreatePollViewController.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreatePollViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createPollButton: UIButton!
    var createPollViewModel: CreatePollViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPollViewModel = CreatePollViewModel(
            createPollTaps: createPollButton.rx.tap.asDriver()
        )
        
        guard let createPollViewModel = createPollViewModel else {
            return
        }
        
        createPollViewModel.createPollAction
            .asObservable()
            .subscribe(onNext: { action in
            
        }).addDisposableTo(rx_disposeBag)
        
        setup(createPollViewModel: createPollViewModel)
        
        createPollViewModel
            .createPollEnabled
            .do(onNext: { en in
                
            })
            .drive(createPollButton.rx.enabled)
            .addDisposableTo(rx_disposeBag)
        
        createPollViewModel.createdPoll.drive(
            onNext: { result in
                
            }
        ).addDisposableTo(rx_disposeBag)
        
        createPollViewModel.question
            .asObservable()
            .subscribe(onNext: { string in
            
        }).addDisposableTo(rx_disposeBag)
    }
    
    func setup(createPollViewModel: CreatePollViewModel) {
        collectionView.dataSource = nil
        collectionView.delegate = nil
        
        collectionView.register(CreatePollFooterCell.nib(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: String(describing: CreatePollFooterCell.self))
        
        collectionView.register(BasicHeaderCell.nib(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: BasicHeaderCell.self))
        
        collectionView.register(
            QuestionCell.nib(),
            forCellWithReuseIdentifier: String(describing: QuestionCell.self)
        )
        
        collectionView.register(
            AnswerOptionCell.nib(),
            forCellWithReuseIdentifier: String(describing: AnswerOptionCell.self)
        )
        
        collectionView.rx
            .setDelegate(self)
            .addDisposableTo(rx_disposeBag)
        
        createPollViewModel
            .createPollSectionItems?
            .bindTo(collectionView.rx.items(dataSource: createPollViewModel.dataSource))
            .addDisposableTo(rx_disposeBag)
        
        collectionView.rx
            .itemSelected
            .subscribe(onNext: { item in
            
        }).addDisposableTo(rx_disposeBag)
        
    }
}

extension CreatePollViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard let createPollViewModel = createPollViewModel else {
            return CGSize.zero
        }
        
        switch createPollViewModel.dataSource.sectionModels[section] {
        case .question:
            return CGSize.zero
        case .answerOption:
            return CGSize(width: UIScreen.main.bounds.width, height: 45)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let createPollViewModel = createPollViewModel else {
            return CGSize.zero
        }
        
        switch createPollViewModel.dataSource.sectionModels[section] {
        case .question:
            return CGSize.zero
        case .answerOption:
            return CGSize(width: UIScreen.main.bounds.width, height: 25)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
}
extension CreatePollViewController: StoryboardIdentifiable {}
