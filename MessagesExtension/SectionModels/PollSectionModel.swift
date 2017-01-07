//
//  PollSectionModel.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources


enum PollSectionModel {
    case existing(title: String, items: [PollCellViewModel])
}

extension PollSectionModel: SectionModelType {
    typealias Item = Any
    
    var items: [Item] {
        switch self {
        case .existing(title: _, items: let items):
            return items.map{$0}
        }
    }
    
    var header: String? {
        switch self {
        case .existing(title: let title, items: _):
            return title
        }
    }
    
    init(original: PollSectionModel, items: [Item]) {
        self = original
    }
}

struct PollCellViewModel {
    let title: String
}
