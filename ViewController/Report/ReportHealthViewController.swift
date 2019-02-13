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
    var costTop: Int!
    var costDown: Int!
    var colorsLevelPressure: [UIColor] = [UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0),
                                          UIColor(red: 0.87, green: 0.40, blue: 0.17, alpha: 1.0),
                                          UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0),
                                          UIColor(red: 0.96, green: 0.72, blue: 0.62, alpha: 1.0),
                                          UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0),
                                          UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let setDate = formatter.string(from: date)
        saveDate = setDate
        getDataKidney()
        getDataDiabetes()
        getDataPressure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "รายงานสุขภาพ"
        configPicker()
        getDataKidney()
        getDataDiabetes()
        getDataPressure()

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
            self.getDataPressure()
        }
    }

    func getDataKidney() {
        dateTimeKidneyLabel.text = saveDate
        let predicate = NSPredicate(format: "dateTime = %@", self.saveDate as CVarArg)
        let kidneyResource = self.realm!.objects(KidneyResrouce.self).filter(predicate).last
        if kidneyResource == nil {
            costGFRLabel.text = "000"
            levelKidneyLabel.text = "ไม่มีข้อมูล"
            warningKidneyImageView.image = nil
            levelKidneyLabel.backgroundColor = UIColor(red: 0.302, green: 0.5608, blue: 0.7961, alpha: 1.0)
            return
        }
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
        dateTimeDiabetesLabel.text = saveDate
        let predicate = NSPredicate(format: "dateTime = %@", self.saveDate as CVarArg)
        let diabetesResource = self.realm!.objects(DiabetesResrouce.self).filter(predicate).last
        if diabetesResource == nil {
            costSugarLabel.text = "000"
            levelDiabetesLabel.text = "ไม่มีข้อมูล"
            warningDiabetesImageView.image = nil
            levelDiabetesLabel.backgroundColor = UIColor(red: 0.5412, green: 0.3922, blue: 0.7412, alpha: 1.0)
            return
        }
        let costSugar: Int = diabetesResource?.costSugar ?? 0
        let statusEating = diabetesResource?.statusEating ?? "ก่อนอาหาร"

        let userResource = realm?.objects(UserResource.self)
        let isDiabetes = userResource?.last?.isDiabetes ?? false

        costSugarLabel.text = String(format: "%i", diabetesResource?.costSugar ?? 0)
        levelDiabetesLabel.text = diabetesResource?.diabetesLevel ?? ""

        if isDiabetes == false {
            getLevelNormal(costSugar: costSugar, statusEating: statusEating)
        } else {
            getLevelDiabetes(costSugar: costSugar, statusEating: statusEating)
        }
    }

    func getLevelNormal(costSugar: Int, statusEating: String) {
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
    }

    func getLevelDiabetes(costSugar: Int, statusEating: String) {
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

    func getDataPressure() {
        dateTimePressureLabel.text = saveDate
        let predicate = NSPredicate(format: "dateTime = %@", self.saveDate as CVarArg)
        let pressureResource = self.realm!.objects(PressureResource.self).filter(predicate).last
        if pressureResource == nil {
            costPressureTopLabel.text = "000"
            costPressureDownLabel.text = "000"
            levelPresureLabel.text = "ไม่มีข้อมูล"
            levelPresureLabel.backgroundColor = UIColor(red: 1, green: 0.4863, blue: 0.5608, alpha: 1.0)
            warningPressureImageView.image = nil
            costHeartLabel.text = "000"
            levelHeartLabel.text = "ไม่มีข้อมูล"
            warningHeartImageView.image = nil
            levelHeartLabel.backgroundColor = UIColor(red: 1, green: 0.4863, blue: 0.5608, alpha: 1.0)
            return
        }
        let costPressureTop = pressureResource?.costPressureTop ?? 0
        let costPressureDown = pressureResource?.costPressureDown ?? 0
        let costHeartRate = pressureResource?.costHeartRate ?? 0

        costPressureTopLabel.text = String(format: "%i", pressureResource?.costPressureTop ?? 0)
        costPressureDownLabel.text = String(format: "%i", pressureResource?.costPressureDown ?? 0)
        levelPresureLabel.text = pressureResource?.pressureLevel ?? ""
        costHeartLabel.text = String(format: "%i", pressureResource?.costHeartRate ?? 0)
        levelHeartLabel.text = pressureResource?.heartRateLevel ?? ""

        getPressure(costPressureTop: costPressureTop, costPressureDown: costPressureDown)
        getHeartRate(costHeartRate: costHeartRate)
    }

    func getPressure(costPressureTop: Int, costPressureDown: Int) {
        getPresureTop(costPressureTop: costPressureTop)
        getPresureDown(costPressureDown: costPressureDown)

        if costTop < costDown! {
            levelPresureLabel.backgroundColor = colorsLevelPressure[costTop]
            if costTop == 0 {
                warningPressureImageView.image = R.image.warning()
            } else {
                warningPressureImageView.image = nil
            }
        } else {
            levelPresureLabel.backgroundColor = colorsLevelPressure[costDown]
            if costDown == 0 {
                warningPressureImageView.image = R.image.warning()
            } else {
                warningPressureImageView.image = nil
            }
        }
    }

    func getPresureTop(costPressureTop: Int) {
        if costPressureTop >= 180 {
            costTop  = 0
        } else if costPressureTop >= 160 && costPressureTop < 180 {
            costTop  = 1
        } else if costPressureTop >= 140 && costPressureTop < 160 {
            costTop  = 2
        } else if costPressureTop >= 130 && costPressureTop < 140 {
            costTop  = 3
        } else if costPressureTop >= 120 && costPressureTop < 130 {
            costTop  = 4
        } else if costPressureTop >= 90 && costPressureTop < 120 {
            costTop  = 5
        } else {
            costTop  = 0
        }
    }

    func getPresureDown(costPressureDown: Int) {
        if costPressureDown >= 110 {
            costDown  = 0
        } else if costPressureDown >= 100 && costPressureDown < 110 {
            costDown  = 1
        } else if costPressureDown >= 90 && costPressureDown < 100 {
            costDown  = 2
        } else if costPressureDown >= 85 && costPressureDown < 90 {
            costDown  = 3
        } else if costPressureDown >= 80 && costPressureDown < 85 {
            costDown  = 4
        } else if costPressureDown >= 60 && costPressureDown < 80 {
            costDown  = 5
        } else {
            costDown  = 0
        }
    }

    func getHeartRate(costHeartRate: Int) {
        if costHeartRate >= 101 {
            warningHeartImageView.image = R.image.warning()
            levelHeartLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
        } else if costHeartRate >= 85 && costHeartRate < 101 {
            warningHeartImageView.image = nil
            levelHeartLabel.backgroundColor = UIColor(red: 0.87, green: 0.40, blue: 0.17, alpha: 1.0)
        } else if costHeartRate >= 70 && costHeartRate < 85 {
            warningHeartImageView.image = nil
            levelHeartLabel.backgroundColor = UIColor(red: 0.96, green: 0.72, blue: 0.62, alpha: 1.0)
        } else if costHeartRate >= 60 && costHeartRate < 70 {
            warningHeartImageView.image = nil
            levelHeartLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
        } else if costHeartRate >= 41 && costHeartRate < 60 {
            warningHeartImageView.image = nil
            levelHeartLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
        } else {
            warningHeartImageView.image = R.image.warning()
            levelHeartLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
        }
    }
}
