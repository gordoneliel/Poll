//
//  PollsViewModel.swift
//  Poll
//
//  Created by Eliel Gordon on 9/17/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxDataSources
import RxRealm

struct PollsViewModel {
    let realm = try! Realm()
    let pollSectionItems: Observable<[PollSectionModel]>?
    
    let addPollTapSubject = PublishSubject<Void>()
    
    //Datasource
    let dataSource = RxCollectionViewSectionedReloadDataSource<PollSectionModel>()
    
    init() {
        let addPollTapSubject = self.addPollTapSubject
        
        pollSectionItems = Observable
            .from(self.realm.objects(Poll.self))
            .map (Array.init)
            .map { (polls: [Poll]) -> [PollSectionModel] in
                
                let pollItems = polls.map { poll -> PollCellViewModel in
                    PollCellViewModel(title: poll.question?.content ?? "")
                }
                
            return [PollSectionModel.existing(title: "Your Polls", items: pollItems)]
        }
        
        dataSource.configureCell = { (dataSource, cv, indexPath, item) in
            switch dataSource.sectionModels[indexPath.section] {
            case .existing(title: _, items: let items):
                let pollCell = cv.dequeueReusableCell(withReuseIdentifier: String(describing: PollCell.self), for: indexPath) as! PollCell
                
                pollCell.pollCellViewModel = items[indexPath.row]
                return pollCell
            }
        }
        
        //section headers
        dataSource.supplementaryViewFactory = { (dataSource, cv, kind, indexPath) in
            switch kind {
            case UICollectionElementKindSectionHeader:
                let headerView = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: String(describing: NewPollCell.self),
                                                                     for: indexPath) as! NewPollCell
                
                headerView.tappable = Tappable(tapSubject: addPollTapSubject)
                return headerView
                
            default: return UICollectionReusableView()
            }
        }

    }
}

struct Tappable {
    var tapSubject: PublishSubject<Void>
}
