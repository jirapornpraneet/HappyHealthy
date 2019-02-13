//
//  DiabetesViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 24/1/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class DiabetesViewController: UIViewController {

    @IBOutlet var costSugarTextField: UITextField!
    @IBOutlet var statusEatingSegmented: UISegmentedControl!
    @IBOutlet var dateTimePicker: UIDatePicker!
    @IBOutlet var saveButton: UIButton!

    var statusEating = "ก่อนอาหาร"
    var dateTime: String = ""
    var realm = try? Realm()
    var diabetesLevel: String = ""
    var costSugar = 0

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

    @IBAction func segmentSelectStatusEatingValueChange(_ sender: Any) {
        let segment: UISegmentedControl = (sender as? UISegmentedControl)!
        if segment.selectedSegmentIndex == 0 {
            statusEating = "ก่อนอาหาร"
        } else {
            statusEating = "หลังอาหาร"
        }
    }

    @IBAction func saveDataClicked(_ sender: Any) {
        if costSugarTextField.text == "" {
            alertShowInputCostSugar()
        } else {
            costSugar = Int(costSugarTextField.text!)!
            let userResource = realm?.objects(UserResource.self)
            let isDiabetes = userResource?.last?.isDiabetes
            var diabetesStatus = "คนปกติ"
            if isDiabetes == false {
                diabetesStatus = "คนปกติ"
                if statusEating == "ก่อนอาหาร" {
                    diabetesLevel = peopleNormalBefore()
                } else {
                    diabetesLevel = peopleNormalAfter()
                }
            } else {
                diabetesStatus = "เบาหวาน"
                if statusEating == "ก่อนอาหาร" {
                    diabetesLevel = peopleDiabetesBefore()
                } else {
                    diabetesLevel = peopleDiabetesAfter()
                }
            }
            let alertShow = UIAlertController(title:
                String(format: "คุณต้องการบันทึกข้อมูลใช่ไหม?"), message:
                String(format: "วันที่ : %@ \n ค่าน้ำตาลในเลือด%@ : %i \n อยู่ในเกณฑ์ที่ : %@ \n  สถานะที่ : %@ ",
                       dateTime,
                       statusEating,
                       costSugar,
                       diabetesLevel,
                       diabetesStatus), preferredStyle: UIAlertController.Style.alert)
            alertShow.addAction(UIAlertAction(title: "บันทึก",
                                              style: UIAlertAction.Style.default,
                                              handler: { (_) in
                                                alertShow.dismiss(animated: true, completion: nil)
                                                self.saveDataDiabetes()
                                                self.performSegue(withIdentifier: "ShowDiabetes", sender: sender)
            }))
            alertShow.addAction(UIAlertAction(title: "ยกเลิก",
                                              style: UIAlertAction.Style.default, handler: { (_) in
                                                alertShow.dismiss(animated: true, completion: nil)
            }))
            self.present(alertShow, animated: true, completion: nil)
        }
    }

    func saveDataDiabetes() {
        let diabetesResource = realm?.objects(DiabetesResrouce.self)
        let diabetes = DiabetesResrouce()
        diabetes.dateTime = dateTime
        diabetes.costSugar = Int(costSugarTextField.text ?? "") ?? 0
        diabetes.diabetesLevel = diabetesLevel
        diabetes.statusEating = statusEating

        if diabetesResource?.count == 0 {
            diabetes.diabetesId = 1
        } else {
            diabetes.diabetesId = (diabetesResource?.last?.diabetesId)! + 1
        }

        try? realm?.write {
            realm?.add(diabetes)
        }
    }

    func alertShowInputCostSugar() {
        let alertShowSave = UIAlertController(title: "กรุณาใส่ข้อมูลโรคเบาหวาน",
                                              message: "คุณต้องใส่ค่าน้ำตาลในเลือดก่อนทำการบันทึก",
                                              preferredStyle: UIAlertController.Style.alert)
        alertShowSave.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertShowSave, animated: true, completion: nil)
    }

    func peopleNormalBefore() -> String {
        if costSugar >= 126 {
            diabetesLevel  = "วินิจฉัยเป็นเบาหวาน"
        } else if costSugar >= 70 && costSugar < 126 {
            diabetesLevel = "ปกติ"
        } else {
            diabetesLevel = "น้ำตาลในเลือดต่ำกว่าปกติ"
        }
        return  diabetesLevel
    }

    func peopleNormalAfter() -> String {
        if costSugar >= 200 {
            diabetesLevel  = "วินิจฉัยเป็นเบาหวาน"
        } else if costSugar >= 70 && costSugar < 200 {
            diabetesLevel = "ปกติ"
        } else {
            diabetesLevel = "น้ำตาลในเลือดต่ำกว่าปกติ"
        }
        return diabetesLevel
    }

    func peopleDiabetesBefore() -> String {
        if costSugar >= 130 {
            diabetesLevel  = "พบแพทย์ทันที น้ำตาลในเลือดสูงมาก (อันตราย)"
        } else if costSugar >= 100 && costSugar < 130 {
            diabetesLevel = "รีบปรึกษาแพทย์ น้ำตาลในเลือดสูง"
        } else if costSugar >= 90 && costSugar < 100 {
            diabetesLevel = "ปรึกษาแพทย์ น้ำตาลเในเลือดค่อนข้างสูง"
        } else if costSugar >= 70 && costSugar < 90 {
            diabetesLevel = "น้ำตาลในเลือดปกติ"
        } else {
            diabetesLevel = "พบแพทย์ทันที น้ำตาลในเลือดต่ำ อันตราย"
        }
        return diabetesLevel
    }

    func peopleDiabetesAfter() -> String {
        if costSugar >= 180 {
            diabetesLevel  = "พบแพทย์ทันที น้ำตาลในเลือดสูงมาก (อันตราย)"
        } else if costSugar >= 150 && costSugar < 180 {
            diabetesLevel = "รีบปรึกษาแพทย์ น้ำตาลในเลือดสูง"
        } else if costSugar >= 110 && costSugar < 150 {
            diabetesLevel = "ปรึกษาแพทย์ น้ำตาลในเลือดค่อนข้างสูง"
        } else if costSugar >= 70 && costSugar < 110 {
            diabetesLevel = "น้ำตาลในเลือดปกติ"
        } else {
            diabetesLevel = "พบแพทย์ทันที น้ำตาลในเลือดต่ำ อันตราย"
        }
        return diabetesLevel
    }
}
