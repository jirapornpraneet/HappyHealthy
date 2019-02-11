//
//  FoodResource.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 7/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class FoodResource: Object {
    @objc dynamic var foodId = 0
    @objc dynamic var foodName: String?
    @objc dynamic var foodCalories: Double = 0.0
    @objc dynamic var foodAmount = 0
    @objc dynamic var foodUnit: String?
    @objc dynamic var foodNetweight: Double = 0.0
    @objc dynamic var foodNetUnit: String?
    @objc dynamic var foodProtein: Double = 0.0
    @objc dynamic var foodFat: Double = 0.0
    @objc dynamic var foodCarbohydrate: Double = 0.0
    @objc dynamic var foodSugar: Double = 0.0
    @objc dynamic var foodSodium: Double = 0.0
    @objc dynamic var foodDetail: String?
    @objc dynamic var foodType = 0
}
