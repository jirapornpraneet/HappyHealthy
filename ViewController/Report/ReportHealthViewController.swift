//
//  ReportHealthViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 5/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import AAPickerView
import RealmSwift

class ReportHealthViewController: UIViewController {

    @IBOutlet weak var dateTimePicker: AAPickerView!
    @IBOutlet weak var dateTimeDiabetesLabel: UILabel!
    @IBOutlet weak var costSugarLabel: UILabel!
    @IBOutlet weak var levelDiabetesLabel: UILabel!
    @IBOutlet weak var warningDiabetesImageView: UIImageView!

    @IBOutlet weak var dateTimeKidneyLabel: UILabel!
    @IBOutlet weak var costGFRLabel: UILabel!
    @IBOutlet weak var levelKidneyLabel: UILabel!
    @IBOutlet weak var warningKidneyImageView: UIImageView!

    @IBOutlet weak var dateTimePressureLabel: UILabel!
    @IBOutlet weak var costPressureTopLabel: UILabel!
    @IBOutlet weak var costPressureDownLabel: UILabel!
    @IBOutlet weak var levelPresureLabel: UILabel!
    @IBOutlet weak var costHeartLabel: UILabel!
    @IBOutlet weak var levelHeartLabel: UILabel!
    @IBOutlet weak var warningPressureImageView: UIImageView!
    @IBOutlet weak var warningHeartImageView: UIImageView!

    var saveDate: String = ""
    var realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let setDate = formatter.string(from: date)
        saveDate = setDate
        getDataKidney()
        getDataDiabetes()
    }

    override func viewWillAppear(_ animated: Bool) {
        configPicker()

    }

    func configPicker() {
        dateTimePicker.text = saveDate
        dateTimePicker.pickerType = .date
        dateTimePicker.datePicker?.datePickerMode = .date
        dateTimePicker.dateFormatter.dateFormat = "dd-MM-yyyy"

        dateTimePicker.valueDidSelected = { date in
            let dateFormatShow = DateFormatter()
            dateFormatShow.dateFormat = "dd-MM-yyyy"
            let setDate  = dateFormatShow.string(from: (date as? Date)!)
            self.saveDate = setDate
            self.getDataKidney()
            self.getDataDiabetes()
        }
    }

    func getDataKidney() {
        let predicate = NSPredicate(format: "dateTime = %@", self.saveDate as CVarArg)
        let kidneyResource = self.realm!.objects(KidneyResrouce.self.self).filter(predicate).first
        dateTimeKidneyLabel.text = kidneyResource?.dateTime ?? ""
        costGFRLabel.text = String(format: "%i", kidneyResource?.costGFR ?? 0)
        levelKidneyLabel.text = kidneyResource?.kidneyLevel ?? ""

        let costGFR: Int = kidneyResource?.costGFR ?? 0

        if costGFR >= 90 {
            warningKidneyImageView.image = nil
            levelKidneyLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
        } else if costGFR >= 60 && costGFR < 90 {
            warningKidneyImageView.image = nil
            levelKidneyLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
        } else if costGFR >= 30 && costGFR < 60 {
            warningKidneyImageView.image = nil
            levelKidneyLabel.backgroundColor = UIColor(red: 0.93, green: 0.70, blue: 0.58, alpha: 1.0)
        } else if costGFR >= 15 && costGFR < 30 {
            warningKidneyImageView.image = nil
            levelKidneyLabel.backgroundColor = UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0)
        } else {
            warningKidneyImageView.image = R.image.warning()
            levelKidneyLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
        }
    }

    func getDataDiabetes() {
        let predicate = NSPredicate(format: "dateTime = %@", self.saveDate as CVarArg)
        let diabetesResource = self.realm!.objects(DiabetesResrouce.self.self).filter(predicate).first
        let costSugar: Int = diabetesResource?.costSugar ?? 0
        let statusEating = diabetesResource?.statusEating ?? "ก่อนอาหาร"
        let userResource = realm?.objects(UserResource.self)
        let isDiabetes = userResource?.last?.isDiabetes ?? false

        dateTimeDiabetesLabel.text = diabetesResource?.dateTime ?? ""
        costSugarLabel.text = String(format: "%i", diabetesResource?.costSugar ?? 0)
        levelDiabetesLabel.text = diabetesResource?.diabetesLevel ?? ""

        if isDiabetes == false {
            if statusEating == "ก่อนอาหาร" {
                if costSugar >= 126 {
                    warningDiabetesImageView.image = R.image.warning()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 126 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningDiabetesImageView.image = R.image.warning()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            } else {
                if costSugar >= 200 {
                    warningDiabetesImageView.image = R.image.warning()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 200 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningDiabetesImageView.image = R.image.warning()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            }
        } else {
            if statusEating == "ก่อนอาหาร" {
                if costSugar >= 130 {
                    warningDiabetesImageView.image = R.image.warning()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 100 && costSugar < 130 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0)
                } else if costSugar >= 90 && costSugar < 100 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 90 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            } else {
                if costSugar >= 180 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 150 && costSugar < 180 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0)
                } else if costSugar >= 110 && costSugar < 150 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 110 {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningDiabetesImageView.image = nil
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            }
        }
    }
}
