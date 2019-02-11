//
//  ExerciseResource.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 11/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseResource: Object {
    @objc dynamic var exerciseId = 0
    @objc dynamic var exerciseName: String?
    @objc dynamic var exerciseCalories: Double = 0.0
    @objc dynamic var exerciseDuration: Double = 0.0
    @objc dynamic var exerciseDisease: String?
    @objc dynamic var exerciseDetail: String?
    @objc dynamic var exerciseDescription: String?
}
