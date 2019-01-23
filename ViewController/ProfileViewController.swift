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
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    @IBOutlet var bmiLabel: UILabel!
    @IBOutlet var bmrLabel: UILabel!
    @IBOutlet var showBmiLabel: UILabel!
    @IBOutlet var showBmiImageView: UIImageView!
    @IBOutlet var diabetesSegmentedControl: UISegmentedControl!
    @IBOutlet var scrollView: UIScrollView!

    var realm = try? Realm()
    var gender = "male"
    var isDiabetes = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        getDataUser()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "ข้อมูลผู้ใช้งาน"
        self.tabBarController?.navigationItem.rightBarButtonItem = saveData
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    @objc func dismissKeyboard() {
        scrollView.endEditing(true)
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
        let weigth = Double(weightTextField.text!)!
        let height = Double(heightTextField.text!)!
        let bmi = ((weigth) / (((height) / 100) * (height) / 100))
        let age = Int(ageTextField.text!)!

        if gender == "male" {
            bmr = 66 + (13.7 * (weigth)) + (5 * Double(height)) - (6.8 * Double(age))
        } else {
            bmr = 665 + (9.6 * (weigth)) + (1.8 * Double(height)) - (4.7 * Double(age))
        }

        let user = UserResource()
        user.name = nameTextField.text
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

        getDataUser()
    }

    func getDataUser() {
        let userResource = realm?.objects(UserResource.self)
        nameTextField.text = userResource?.last?.name ?? ""
        ageTextField.text = String(format: "%i", userResource?.last?.age ?? 0)
        weightTextField.text = String(format: "%.02f", userResource?.last?.weight ?? 0.0)
        heightTextField.text = String(format: "%.02f", userResource?.last?.height ?? 0.0)
        bmiLabel.text = String(format: "%.02f", userResource?.last?.bmi ?? 0.0)
        bmrLabel.text = String(format: "%.02f", userResource?.last?.bmr ?? 0.0)

        if userResource?.last?.gender == "female" {
            genderSegmentedControl.selectedSegmentIndex = 1
        }

        if userResource?.last?.isDiabetes == true {
            diabetesSegmentedControl.selectedSegmentIndex = 1
        }

        let bmi: Double = (userResource?.last?.bmi ?? 0.0)
        if bmi <= 18.5 {
            showBmiLabel.text = "ผอม"
            showBmiImageView.image = R.image.bmi1()
        } else if bmi < 22.9 {
            showBmiLabel.text = "ปกติ"
            showBmiImageView.image = R.image.bmi2()
        } else if bmi < 24.9 {
            showBmiLabel.text = "ท้วม"
            showBmiImageView.image = R.image.bmi3()
        } else if bmi < 29.9 {
            showBmiLabel.text = "อ้วนปานกลาง"
            showBmiImageView.image = R.image.bmi4()
        } else {
            showBmiLabel.text = "อ้วน"
            showBmiImageView.image = R.image.bmi5()
        }
    }
}
