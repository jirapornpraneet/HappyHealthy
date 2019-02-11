//
//  FoodHistoryResource.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 11/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class FoodHistoryResource: Object {
    @objc dynamic var historyFoodId = 0
    @objc dynamic var historyFoodDate: String?
    @objc dynamic var foodId = 0
    @objc dynamic var foodTotalAmount: Double = 0.0
    @objc dynamic var sumFoodCalories: Double = 0.0
    @objc dynamic var sumFoodProtein: Double = 0.0
    @objc dynamic var sumFoodFat: Double = 0.0
    @objc dynamic var sumFoodCarbohydrate: Double = 0.0
    @objc dynamic var sumFoodSugar: Double = 0.0
    @objc dynamic var sumFoodSodium: Double = 0.0
}
