//
//  AnswerOption.swift
//  Poll
//
//  Created by Eliel Gordon on 9/17/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation
import RealmSwift

class AnswerOption: Object {
    dynamic var content: String = ""
    dynamic var image: NSData?
}
