//
//  ViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 11/12/2561 BE.
//  Copyright © 2561 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var realm = try? Realm()
    var foodResource: Results<FoodResource>!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        foodResource = realm?.objects(FoodResource.self)
        if foodResource.count == 0 {
            addDataFoodPlistToDataBaseRealm()
        }
    }

    func addDataFoodPlistToDataBaseRealm() {
        var dictFoodPlistPath: NSDictionary!
        if let foodPlistPath = R.file.foodPlist()?.path {
            dictFoodPlistPath = NSDictionary(contentsOfFile: foodPlistPath)
        }

        for item in 1...dictFoodPlistPath.count {
            let dictFood = dictFoodPlistPath.object(forKey: String(format: "Food - %i", item)) as? NSDictionary
            let foodId = dictFood?.object(forKey: "foodId") as? NSNumber
            let foodName = dictFood?.object(forKey: "foodName") as? String
            let foodCalories = dictFood?.object(forKey: "foodCalories") as? NSNumber
            let foodUnit = dictFood?.object(forKey: "foodUnit") as? String
            let foodNetUnit = dictFood?.object(forKey: "foodNetUnit") as? String
            let foodFat = dictFood?.object(forKey: "foodFat") as? NSNumber
            let foodProtein = dictFood?.object(forKey: "foodProtein") as? NSNumber
            let foodSodium = dictFood?.object(forKey: "foodSodium") as? NSNumber
            let foodSugars = dictFood?.object(forKey: "foodSugars") as? NSNumber
            let foodCarbohydrate = dictFood?.object(forKey: "foodCarbohydrate") as? NSNumber
            let foodNetweight = dictFood?.object(forKey: "foodNetweight") as? NSNumber
            let foodDetail = dictFood?.object(forKey: "foodDetail") as? String

            let foodResource = FoodResource()
            foodResource.foodId = Int(truncating: foodId!)
            foodResource.foodName = foodName
            foodResource.foodAmount = 1
            foodResource.foodCalories = Double(truncating: foodCalories ?? 0.0)
            foodResource.foodUnit = foodUnit ?? ""
            foodResource.foodNetUnit = foodNetUnit ?? ""
            foodResource.foodFat = Double(truncating: foodFat ?? 0.0)
            foodResource.foodProtein = Double(truncating: foodProtein ?? 0.0)
            foodResource.foodSodium = Double(truncating: foodSodium ?? 0.0)
            foodResource.foodSugar = Double(truncating: foodSugars ?? 0.0)
            foodResource.foodCarbohydrate = Double(truncating: foodCarbohydrate ?? 0.0)
            foodResource.foodNetweight = Double(truncating: foodNetweight ?? 0.0)
            foodResource.foodDetail = foodDetail ?? ""

            try? realm?.write {
                realm?.add(foodResource)
            }
        }
    }
}
