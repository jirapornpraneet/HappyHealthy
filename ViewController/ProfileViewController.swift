//
//  ProfileViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 22/1/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {

    @IBOutlet var saveData: UIBarButtonItem!
    @IBOutlet var nameUserTextField: UITextField!
    @IBOutlet var ageUserTextField: UITextField!
    @IBOutlet var weightUserTextField: UITextField!
    @IBOutlet var heightUserTextField: UITextField!
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    @IBOutlet var bmiUserLabel: UILabel!
    @IBOutlet var bmrUserLabel: UILabel!
    @IBOutlet var showBmiUserLabel: UILabel!
    @IBOutlet var showImageBmi: UIImageView!
    @IBOutlet var diabetesSegmentedControl: UISegmentedControl!

    var realm = try? Realm()
    var gender = "male"
    var isDiabetes = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        getDataUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "ข้อมูลผู้ใช้งาน"
        self.tabBarController?.navigationItem.rightBarButtonItem = saveData
    }

    @IBAction func segmentSelectGenderTypeValueChange(_ sender: Any) {
        let segment: UISegmentedControl = (sender as? UISegmentedControl)!
        if segment.selectedSegmentIndex == 0 {
            gender = "male"
        } else {
            gender = "female"
        }
    }

    @IBAction func segmentSelectIsDiabetesTypeValueChange(_ sender: Any) {
        let segment: UISegmentedControl = (sender as? UISegmentedControl)!
        if segment.selectedSegmentIndex == 0 {
            isDiabetes = false
        } else {
            isDiabetes = true
        }
    }

    @IBAction func saveDataClicked(_ sender: Any) {
        var bmr: Double!
        let weigth = Double(weightUserTextField.text!)!
        let height = Double(heightUserTextField.text!)!
        let bmi = ((weigth) / (((height) / 100)*2))
        let age = Int(ageUserTextField.text!)!

        if gender == "male" {
            bmr = 66 + (13.7 * (weigth)) + (5 * Double(height)) - (6.8 * Double(age))
        } else {
            bmr = 665 + (9.6 * (weigth)) + (1.8 * Double(height)) - (4.7 * Double(age))
        }

        let user = UserResource()
        user.name = nameUserTextField.text
        user.gender = gender
        user.isDiabetes = isDiabetes
        user.age = age
        user.weight = weigth
        user.height = height
        user.bmi = bmi
        user.bmr = bmr

        try? realm?.write {
            realm?.add(user)
        }
    }

    func getDataUser() {
        let results = realm?.objects(UserResource.self)
        nameUserTextField.text = results!.last!.name!
        ageUserTextField.text = String(format: "%i", results!.last!.age)
        weightUserTextField.text = String(format: "%.02f", results!.last!.weight)
        heightUserTextField.text = String(format: "%.02f", results!.last!.height)
        bmiUserLabel.text = String(format: "%.02f", results!.last!.bmi)
        bmrUserLabel.text = String(format: "%.02f", results!.last!.bmr)

        if results?.last?.gender == "female" {
            genderSegmentedControl.selectedSegmentIndex = 1
        }

        if (results?.last?.isDiabetes)! {
            diabetesSegmentedControl.selectedSegmentIndex = 1
        }
    }
}
