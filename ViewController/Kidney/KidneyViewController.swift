//
//  KidneyViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 1/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class KidneyViewController: UIViewController {

    @IBOutlet var costGFRTextField: UITextField!
    @IBOutlet var dateTimePicker: UIDatePicker!
    @IBOutlet var saveButton: UIButton!

    var dateTime: String = ""
    var realm = try? Realm()
    var kidneyLevel: String = ""
    var costGFR = 0

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
        if costGFRTextField.text == "" {
            alertShowInputCostGFR()
        } else {
            costGFR = Int(costGFRTextField.text!)!
            if costGFR >= 90 {
                kidneyLevel  = "ปกติ"
            } else if costGFR >= 60 && costGFR < 90 {
                kidneyLevel = "ลดลงเล็กน้อย"
            } else if costGFR >= 30 && costGFR < 60 {
                kidneyLevel = "ลดลงปานกลาง"
            } else if costGFR >= 15 && costGFR < 30 {
                kidneyLevel = "ลดลงมาก"
            } else {
                kidneyLevel = "ลดลงอันตราย"
            }
            let alertShow = UIAlertController(title:
                String(format: "คุณต้องการบันทึกข้อมูลใช่ไหม?"), message:
                String(format: "วันที่ : %@ \n ค่าการทำงานไต : %i\n  อยู่ในเกณฑ์ที่ : %@ ",
                       dateTime,
                       costGFR,
                       kidneyLevel), preferredStyle: UIAlertController.Style.alert)
            alertShow.addAction(UIAlertAction(title: "บันทึก",
                                              style: UIAlertAction.Style.default,
                                              handler: { (_) in
                                                alertShow.dismiss(animated: true, completion: nil)
                                                self.saveDataKidney()
                                                self.performSegue(withIdentifier: "ShowKidney", sender: sender)
            }))
            alertShow.addAction(UIAlertAction(title: "ยกเลิก",
                                              style: UIAlertAction.Style.default, handler: { (_) in
                                                alertShow.dismiss(animated: true, completion: nil)
            }))
            self.present(alertShow, animated: true, completion: nil)
        }
    }

    func saveDataKidney() {
        let kidneyResource = realm?.objects(KidneyResrouce.self)
        let kidney = KidneyResrouce()
        kidney.dateTime = dateTime
        kidney.costGFR = Int(costGFRTextField.text!)!
        kidney.kidneyLevel = kidneyLevel

        if kidneyResource?.count == 0 {
            kidney.kidneyId = 1
        } else {
            kidney.kidneyId = (kidneyResource?.last?.kidneyId)! + 1
        }

        try? realm?.write {
            realm?.add(kidney)
        }
    }

    func alertShowInputCostGFR() {
        let alertShowSave = UIAlertController(title: "กรุณาใส่ข้อมูลโรคไต",
                                              message: "คุณต้องใส่ค่าการทำงานไตก่อนทำการบันทึก",
                                              preferredStyle: UIAlertController.Style.alert)
        alertShowSave.addAction(UIAlertAction(title: "ตกลง", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertShowSave, animated: true, completion: nil)
    }
}
