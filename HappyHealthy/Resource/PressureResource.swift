//
//  PressureResource.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 4/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class PressureResource: Object {
    @objc dynamic var pressureId = 0
    @objc dynamic var dateTime: String?
    @objc dynamic var costPressureTop = 0
    @objc dynamic var costPressureDown = 0
    @objc dynamic var costHeartRate = 0
    @objc dynamic var pressureLevel: String?
    @objc dynamic var heartRateLevel: String?
}
