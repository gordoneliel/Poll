//
//  Poll.swift
//  Poll
//
//  Created by Eliel Gordon on 9/17/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation
import RealmSwift

class Poll: Object {
    dynamic var question: Question?
    var answerOptions = List<AnswerOption>()
}
