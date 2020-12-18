//
//  KidneyResrouce.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 1/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class KidneyResrouce: Object {
    @objc dynamic var kidneyId = 0
    @objc dynamic var dateTime: String?
    @objc dynamic var costGFR = 0
    @objc dynamic var kidneyLevel: String?
}
