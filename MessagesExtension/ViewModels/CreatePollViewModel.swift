//
//  CreatePollViewModel.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxDataSources
import RxRealm

struct CreatePollViewModel {
    let realm = try! Realm()
    
    //Datasource
    let dataSource = RxCollectionViewSectionedReloadDataSource<CreatePollSectionModel>()
    let createPollSectionItems: Observable<[CreatePollSectionModel]>?
    var question: Variable<String> = Variable("Your question here")
    var answerOptions: Variable<[String]> = Variable([])
    let createPollEnabled: Driver<Bool>
    let validatedQuestion: Driver<ValidationResult>
    let validatedAnswerOptions: Driver<ValidationResult>
    let createdPoll: Driver<ValidationResult>
    let createPollAction = Variable(CreatePollAction.NoAction)
    
    init(createPollTaps: Driver<Void>) {
        
        let pollAction = createPollAction
        // Validations
        let validationService = ValidationService.sharedInstance
        
        validatedQuestion = question
            .asDriver()
            .map { question in
            return validationService.validateQuestion(question)
        }
        
        validatedAnswerOptions = answerOptions
            .asDriver()
            .map { options in
            return validationService.validateAnswerOptions(options)
        }
        
        let validatedQuestionAndAnswers = Driver.combineLatest(
            question.asDriver(),
            answerOptions.asDriver()
        ){ return ($0, $1) }

        createdPoll = createPollTaps
            .asObservable()
            .withLatestFrom(validatedQuestionAndAnswers)
            .do(onNext: { (question, answers) in
                
                let pollQuestion = Question(value: question)
                
                let answerOptions = answers.map { AnswerOption(value: $0) }
                
                _ = Poll(value: [pollQuestion, answerOptions])
                _ = Realm.rx.add()

            })
            .flatMapLatest {
                (question, answers) in
                
                return Driver.just(ValidationResult.ok(message: "Created Poll"))
                
            }.asDriver(onErrorDriveWith: Driver.just(ValidationResult.failed(message: "Failed :(")))

        let questionSection = Observable.just(
            CreatePollSectionModel.question(
                title: "Question",
                item: QuestionCellViewModel(content: question)
            )
        )
        
        let answerOptionSection = Observable.just(
            CreatePollSectionModel.answerOption(
                title: "Options",
                items: [AnswerOptionCellViewModel(answerOptions: answerOptions)]
            )
        )
        
        createPollSectionItems = Observable.zip(questionSection, answerOptionSection) {
            return [$0, $1]
        }
        
        createPollEnabled = Driver.combineLatest(validatedQuestion, validatedAnswerOptions) {
            question, answerOptions in
            question.isValid && answerOptions.isValid
            }.distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
    
        dataSource.configureCell = { (dataSource, cv, indexPath, item) in
            switch dataSource.sectionModels[indexPath.section] {
            case let .question(_, item):
                let questionCell = cv.dequeueReusableCell(withReuseIdentifier: String(describing: QuestionCell.self), for: indexPath) as! QuestionCell
                
                questionCell.questionCellViewModel = item
                return questionCell
            case let .answerOption(_, items):
                let answerOptionCell = cv.dequeueReusableCell(withReuseIdentifier: String(describing: AnswerOptionCell.self), for: indexPath) as! AnswerOptionCell
                
                answerOptionCell.answerOptionCellViewModel = items[indexPath.row]
                return answerOptionCell
            }
        }
        
        //section headers
        dataSource.supplementaryViewFactory = { (dataSource, cv, kind, indexPath) in
            switch kind {
            case UICollectionElementKindSectionHeader:
                let header = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: String(describing: BasicHeaderCell.self),
                                                                 for: indexPath) as! BasicHeaderCell
                
                return header
                
            case UICollectionElementKindSectionFooter:
                let footer = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: String(describing: CreatePollFooterCell.self),
                                                                 for: indexPath) as! CreatePollFooterCell
                footer.createFooterAction = pollAction
                return footer
                
            default: return UICollectionReusableView()
            }
        }
        
    }
}
