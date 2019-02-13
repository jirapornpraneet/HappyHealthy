//
//  ExerciseHistoryResource.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 12/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseHistoryResource: Object {
    @objc dynamic var historyExerciseId = 0
    @objc dynamic var historyExerciseDate: String?
    @objc dynamic var exerciseId = 0
    @objc dynamic var exerciseName: String?
    @objc dynamic var exerciseDisease: String?
    @objc dynamic var exerciseTotalDuration: Double = 0.0
    @objc dynamic var sumExerciseCalories: Double = 0.0
}
