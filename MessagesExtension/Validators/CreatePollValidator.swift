//
//  CreatePollValidator.swift
//  Poll
//
//  Created by Eliel Gordon on 9/18/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation

struct ValidationService: CreatePollValidatable {
    static let sharedInstance = ValidationService()
}

protocol CreatePollValidatable {
    var minCharacterCount: Int {get}
    
    func validateAnswerOptions(_ answerOptions: [String]) -> ValidationResult
    func validateQuestion(_ question: String) -> ValidationResult
}

extension CreatePollValidatable {
    var minCharacterCount: Int {
        get {
            return 5
        }
    }
    
    func validateAnswerOptions(_ answerOptions: [String]) -> ValidationResult {
        if answerOptions.isEmpty {
            return .empty
        }
        
        return .ok(message: "Valid")
    }
    
    func validateQuestion(_ question: String) -> ValidationResult {
        if question.characters.count < minCharacterCount {
            return .empty
        }
        
        return .ok(message: "Valid")
    }
}


    
enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return "Field Empty"
        case .validating:
            return "validating ..."
        case let .failed(message):
            return message
        }
    }
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
