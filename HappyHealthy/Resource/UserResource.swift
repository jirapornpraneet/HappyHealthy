//
//  UserResource.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 12/12/2561 BE.
//  Copyright © 2561 jirapornpraneetHappyHealthy. All rights reserved.
//

import Foundation
import RealmSwift

class UserResource: NSObject {
    var name: String?
    var gender: String?
    var age: Int?
    var weight: Double?
    var height: Int?
    var bmi: Double?
    var bmr: Double?
    var isDiabetes: String?
}
