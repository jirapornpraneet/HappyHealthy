//
//  FoodDetailViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 11/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class FoodDetailViewController: UIViewController {

    @IBOutlet var nameFoodLabel: UILabel!
    @IBOutlet var kcalFoodLabel: UILabel!
    @IBOutlet var unitFoodLabel: UILabel!
    @IBOutlet var netWeightFoodLabel: UILabel!
    @IBOutlet var netUnitFoodLabel: UILabel!
    @IBOutlet var proteinFoodLabel: UILabel!
    @IBOutlet var fatFoodLabel: UILabel!
    @IBOutlet var carbohydrateFoodLabel: UILabel!
    @IBOutlet var sugarsFoodLabel: UILabel!
    @IBOutlet var sodiumFoodLabel: UILabel!
    @IBOutlet var detailFoodLabel: UILabel!
    @IBOutlet var amountFoodTextField: UITextField!

    var foodDetailResource: FoodResource!
    var totalAmount: Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFoodDetail()
    }

    func getDataFoodDetail() {
        nameFoodLabel.text = foodDetailResource.foodName
        kcalFoodLabel.text = String(format: "%.02f", foodDetailResource.foodCalories)
        amountFoodTextField.text = String(format: "%i", foodDetailResource.foodAmount)
        unitFoodLabel.text = foodDetailResource.foodUnit
        netWeightFoodLabel.text = String(format: "%.02f", foodDetailResource.foodNetweight)
        netUnitFoodLabel.text = foodDetailResource.foodNetUnit
        proteinFoodLabel.text = String(format: "%.02f", foodDetailResource.foodProtein)
        fatFoodLabel.text = String(format: "%.02f", foodDetailResource.foodFat)
        carbohydrateFoodLabel.text = String(format: "%.02f", foodDetailResource.foodCarbohydrate)
        sugarsFoodLabel.text = String(format: "%.02f", foodDetailResource.foodSugar)
        sodiumFoodLabel.text = String(format: "%.02f", foodDetailResource.foodSodium)
        detailFoodLabel.text = foodDetailResource.foodDetail
    }

    @IBAction func amountFoodTextFieldEditingChanged(_ sender: Any) {
        if amountFoodTextField.text == "" {
            return
        }

        totalAmount = Double(amountFoodTextField.text ?? "")
        setDataDetailFood(totalAmount: totalAmount!)
    }

    func setDataDetailFood(totalAmount: Double) {
        nameFoodLabel.text = foodDetailResource.foodName
        kcalFoodLabel.text = String(format: "%.02f", foodDetailResource.foodCalories * totalAmount)
        unitFoodLabel.text = foodDetailResource.foodUnit
        netWeightFoodLabel.text = String(format: "%.02f", foodDetailResource.foodNetweight * totalAmount)
        netUnitFoodLabel.text = foodDetailResource.foodNetUnit
        proteinFoodLabel.text = String(format: "%.02f", foodDetailResource.foodProtein * totalAmount)
        fatFoodLabel.text = String(format: "%.02f", foodDetailResource.foodFat * totalAmount)
        carbohydrateFoodLabel.text = String(format: "%.02f", foodDetailResource.foodCarbohydrate * totalAmount)
        sugarsFoodLabel.text = String(format: "%.02f", foodDetailResource.foodSugar * totalAmount)
        sodiumFoodLabel.text = String(format: "%.02f", foodDetailResource.foodSodium * totalAmount)
        detailFoodLabel.text = foodDetailResource.foodDetail
    }

    @IBAction func saveDataHistoryFood(_ sender: Any) {
        let alertShow = UIAlertController (title: "ยืนยันการบันทึกอาหาร",
                                           message: "คุณแน่ใจใช่ไหม",
                                           preferredStyle: UIAlertController.Style.alert)
        alertShow.addAction(UIAlertAction(title: "บันทึก",
                                          style: UIAlertAction.Style.default,
                                          handler: { (_) in
                                            alertShow.dismiss(animated: true, completion: nil)
                                            self.addDataHistoryFood()
            self.performSegue(withIdentifier: "ShowHistoryFood", sender: sender)
        }))
        alertShow.addAction(UIAlertAction(title: "ยกเลิก" ,
                                          style: UIAlertAction.Style.default,
                                          handler: { (_) in
            alertShow.dismiss(animated: true, completion: nil)
        }))
        self.present(alertShow, animated: true, completion: nil)
    }

    func addDataHistoryFood() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
//        let foodHistoryResource = FoodHistoryTable()
//        foodHistoryResource.History_Food_Date = result
//        foodHistoryResource.Food_Id = Int((getFoodTable?.Food_Id)!)
//        foodHistoryResource.Food_TotalAmount = Double(amountFoodTextField.text!)
//        dbHelper.insertFoodHistory(dataRowFoodHistoryTable: foodHistoryResource)
    }

}
