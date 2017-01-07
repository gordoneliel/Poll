////
////  Poll.swift
////  Poll
////
////  Created by Eliel Gordon on 9/17/16.
////  Copyright © 2016 Eliel Gordon. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//struct Poll {
//    var tally: Tally? {
//        get {
//            return self.tally
//        }
//    }
//    
//    let question: Question
//    let answerOptions: [AnswerOption]
//    
//    func contribute(withAmount amount: Int) {
//        guard let tally = tally else {
//            return
//        }
//        tally.contribute(withAmount: amount)
//    }
//}
//
//// The question for a poll
//struct Question {
//    let description: String
//    let image: UIImage?
//}
//
//// A contribution to a poll
//enum Tally {
//    case increase(by: Int)
//    case decrease(by: Int)
//}
//
//extension Tally {
//    func contribute(withAmount amount: Int) {
//        switch self {
//        case .increase:
//            break
//        case .decrease:
//            break
//        }
//    }
//}
//
//struct AnswerOption {
//    let description: String
//}
//
//let question = Question(description: "What do you like best?", image: nil)
//let answerOptions = [AnswerOption(description: "Lemons"), AnswerOption(description: "Potatoes"), AnswerOption(description: "Cabbage") ]
//let poll = Poll(question: question, answerOptions: answerOptions)
