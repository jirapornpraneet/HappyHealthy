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

    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try? Realm()
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")

        let user = UserResource()
        user.name = "jiraporn"
        user.gender  = "female"

        try? realm?.write {
            realm?.add(user)
        }

        let results = realm?.objects(UserResource.self)
        print(results![0].name!)
        print(results!.last!.name!)
    }
}
