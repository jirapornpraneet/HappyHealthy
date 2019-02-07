//
//  FoodViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 7/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class FoodTableViewController: UITableViewController {
    
    var realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        let foodNames = ["food1", "food2"]
        for foodName in foodNames {
            let foodResource = FoodResource()
            foodResource.foodName = foodName
            try? realm?.write {
                realm?.add(foodResource)
            }
        }
        let food = realm?.objects(FoodResource.self)
        print("food\(String(describing: food))")

    }

}
