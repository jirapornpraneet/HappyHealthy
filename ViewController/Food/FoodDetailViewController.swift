//
//  FoodDetailViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 11/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class FoodDetailViewController: UIViewController {

    var realm = try? Realm()
    var foodDetailResource: FoodResource!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("foodDetail\(String(describing: foodDetailResource.foodName))")
        
    }

}
