//
//  PressureViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 4/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class PressureViewController: UIViewController {

    @IBOutlet var costPressureDownTextField: UITextField!
    @IBOutlet var costPressureTopTextField: UITextField!
    @IBOutlet var costHeartTextField: UITextField!
    @IBOutlet var dateTimePicker: UIDatePicker!
    @IBOutlet var saveButton: UIButton!

    var dateTime: String = ""
    var realm = try? Realm()

    var pressureLevel: String = ""
    var heartRateLevel: String = ""
    var costPressureTop = 0
    var costPressureDown = 0
    var costHeart = 0
    var pressureLevelName: [String] = ["พบแพทย์ทันที ระดับอันตราย",
                                       "พบแพทย์ทันที ระดับสูงมาก",
                                       "พบแพทย์ทันที ระดับสูง",
                                       "พบแพทย์ทันที ระดับค่อนข้างสูง",
                                       "ระดับปกติ",
                                       "ระดับเหมาะสม"]
    var costTop: Int!
    var costDown: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd-MM-yyyy"
        let setDate = dateFormatter.string(from: dateTimePicker.date)
        dateTime = setDate
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")

        let tapGestureRecognizerKeyboard: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self,
                                   action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGestureRecognizerKeyboard)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @IBAction func selectDatePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd-MM-yyyy"
        let setDate = dateFormatter.string(from: dateTimePicker.date)
        dateTime = setDate
    }

    @IBAction func saveDataClicked(_ sender: Any) {
        if costPressureTopTextField.text == "" &&
            costPressureDownTextField.text == "" &&
            costHeartTextField.text == "" {
            alertShowInputCostPressureAndCostHeart()
        } else {
            pressureLevel = levelPressure()
            heartRateLevel = levelHeart()
            let alertShow = UIAlertController(title:
                String(format: "คุณต้องการบันทึกข้อมูลใช่ไหม?"), message: String(format:
                    "วันที่ : %@ \n ค่าความดันโลหิตตัวบน : %i \n ค่าความดันโลหิตตัวล่าง : %i \n อยู่ในเกณฑ์ที่ : %@ " +
                    "\n อัตราการเต้นหัวใจ : %i \n อยู่ในเกณฑ์ที่ : %@ ",
                       dateTime,
                       Int(costPressureTopTextField.text!)!,
                       Int(costPressureDownTextField.text!)!,
                       pressureLevel,
                       Int(costHeartTextField.text!)!,
                       heartRateLevel), preferredStyle: UIAlertController.Style.alert)
            alertShow.addAction(UIAlertAction(title: "บันทึก",
                                              style: UIAlertAction.Style.default,
                                              handler: { (_) in
                                                alertShow.dismiss(animated: true, completion: nil)
                                                self.saveDataPressureAndCostHeart()
                                                self.performSegue(withIdentifier: "ShowPressure", sender: sender)
            }))
            alertShow.addAction(UIAlertAction(title: "ยกเลิก",
                                              style: UIAlertAction.Style.default, handler: { (_) in
                                                alertShow.dismiss(animated: true, completion: nil)
            }))
            self.present(alertShow, animated: true, completion: nil)
        }
    }

    func levelPressureTop() {
        let costPressureTop = Int(costPressureTopTextField.text!)

        if costPressureTop! >= 180 {
            costTop  = 0
        } else if costPressureTop! >= 160 && costPressureTop! < 180 {
            costTop  = 1
        } else if costPressureTop! >= 140 && costPressureTop! < 160 {
            costTop  = 2
        } else if costPressureTop! >= 130 && costPressureTop! < 140 {
            costTop  = 3
        } else if costPressureTop! >= 120 && costPressureTop! < 130 {
            costTop  = 4
        } else if costPressureTop! >= 90 && costPressureTop! < 120 {
            costTop  = 5
        } else {
            costTop  = 0
        }
    }

    func levelPressureDown() {
        let costPressureDown = Int(costPressureDownTextField.text!)
        if costPressureDown! >= 110 {
            costDown  = 0
        } else if costPressureDown! >= 100 && costPressureDown! < 110 {
            costDown  = 1
        } else if costPressureDown! >= 90 && costPressureDown! < 100 {
            costDown  = 2
        } else if costPressureDown! >= 85 && costPressureDown! < 90 {
            costDown  = 3
        } else if costPressureDown! >= 80 && costPressureDown! < 85 {
            costDown  = 4
        } else if costPressureDown! >= 60 && costPressureDown! < 80 {
            costDown  = 5
        } else {
            costDown  = 0
        }
    }

    func levelPressure() -> String {
        levelPressureTop()
        levelPressureDown()
        if costTop < costDown {
            pressureLevel = pressureLevelName[costTop!]
        } else {
            pressureLevel = pressureLevelName[costDown!]
        }
        return pressureLevel
    }

    func levelHeart() -> String {
        let costHeart = Int(costHeartTextField.text!)

        if costHeart! >= 101 {
            heartRateLevel = "ผิดปกติ"
        } else if costHeart! >= 85 && costHeart!  < 101 {
            heartRateLevel = "สูงเกินไป"
        } else if costHeart! >= 70 && costHeart!  < 85 {
            heartRateLevel = "พอใช้"
        } else if costHeart! >= 60 && costHeart!  < 70 {
            heartRateLevel = "ดี"
        } else if costHeart! >= 41 && costHeart!  < 60 {
            heartRateLevel = "ดีมาก"
        } else {
            heartRateLevel = "ผิดปกติ"
        }
        return heartRateLevel
    }

    func saveDataPressureAndCostHeart() {
        let pressure = PressureResource()
        pressure.dateTime = dateTime
        pressure.costPressureTop = Int(costPressureTopTextField.text!)!
        pressure.costPressureDown = Int(costPressureDownTextField.text!)!
        pressure.costHeartRate = Int(costHeartTextField.text!)!
        pressure.pressureLevel = pressureLevel
        pressure.heartRateLevel = heartRateLevel

        try? realm?.write {
            realm?.add(pressure)
        }
    }

    func alertShowInputCostPressureAndCostHeart() {
        let alertShowSave = UIAlertController(title: "กรุณาใส่ข้อมูลโรคความดัน",
                                              message: "คุณต้องใส่ค่าความดันโลหิตและค่าการเต้นหัวใจก่อนทำการบันทึก",
                                              preferredStyle: UIAlertController.Style.alert)
        alertShowSave.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertShowSave, animated: true, completion: nil)
    }

}
