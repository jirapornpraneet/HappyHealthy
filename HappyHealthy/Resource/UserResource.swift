//
//  UserResource.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 12/12/2561 BE.
//  Copyright © 2561 jirapornpraneetHappyHealthy. All rights reserved.
//

import Foundation
import RealmSwift

class UserResource: Object {
    @objc dynamic var name: String?
    @objc dynamic var gender: String?
    @objc dynamic var isDiabetes = false
    @objc dynamic var age = 0
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var height: Double = 0.0
    @objc dynamic var bmi: Double = 0.0
    @objc dynamic var bmr: Double = 0.0
}
