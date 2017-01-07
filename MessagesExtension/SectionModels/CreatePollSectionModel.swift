//
//  CreatePollSectionModel.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

enum CreatePollSectionModel {
    case question(title: String, item: QuestionCellViewModel)
    case answerOption(title: String, items: [AnswerOptionCellViewModel])
}

extension CreatePollSectionModel: SectionModelType {
    typealias Item = Any
    
    var items: [Item] {
        switch self {
        case .question(title: _, item: let item):
            return [item]
        case .answerOption(title: _, items: let items):
            return items.map {$0}
        }
    }
    
    var header: String {
        switch self {
        case .question(title: let title, item: _):
            return title
        case .answerOption(title: let title, items: _):
            return title
        }
    }
    
    init(original: CreatePollSectionModel, items: [Item]) {
        self = original
    }
}

struct AnswerOptionCellViewModel {
    let answerOptions: Variable<[String]>
}

struct QuestionCellViewModel {
    let content: Variable<String>
//    let question: Variable<Question>
}
