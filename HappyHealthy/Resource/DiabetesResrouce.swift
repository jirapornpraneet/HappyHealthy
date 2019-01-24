//
//  DiabetesResrouce.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 24/1/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class DiabetesResrouce: Object {
    @objc dynamic var dateTime: String?
    @objc dynamic var costSugar = 0
    @objc dynamic var diabetesLevel: String?
    @objc dynamic var statusEating: String?
}
