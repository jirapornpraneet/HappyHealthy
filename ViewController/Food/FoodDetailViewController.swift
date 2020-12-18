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
    var realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFoodDetail()
    }

    func getDataFoodDetail() {
        totalAmount = 1.0
        nameFoodLabel.text = foodDetailResource.foodName
        kcalFoodLabel.text = String(format: "%.02f", foodDetailResource.foodCalories)
        amountFoodTextField.text = String(format: "%.02f", totalAmount)
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

        totalAmount = 1.0
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
                                            self.navigationController?.popViewController(animated: true)
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
        let saveDate = formatter.string(from: date)
        let foodHistoryResource = realm?.objects(FoodHistoryResource.self)
        let foodHistoryResources = FoodHistoryResource()

        if foodHistoryResource?.count == 0 {
            foodHistoryResources.historyFoodId = 1
        } else {
            foodHistoryResources.historyFoodId = (foodHistoryResource?.last?.historyFoodId)! + 1
        }

        foodHistoryResources.historyFoodDate = saveDate
        foodHistoryResources.foodId = foodDetailResource.foodId
        foodHistoryResources.foodName = foodDetailResource.foodName
        foodHistoryResources.foodUnit = foodDetailResource.foodUnit
        foodHistoryResources.foodDetail = foodDetailResource.foodDetail
        foodHistoryResources.foodTotalAmount = totalAmount
        foodHistoryResources.sumFoodCalories = foodDetailResource.foodCalories * totalAmount
        foodHistoryResources.sumFoodProtein = foodDetailResource.foodProtein * totalAmount
        foodHistoryResources.sumFoodFat = foodDetailResource.foodFat * totalAmount
        foodHistoryResources.sumFoodCarbohydrate = foodDetailResource.foodCarbohydrate * totalAmount
        foodHistoryResources.sumFoodSugar = foodDetailResource.foodSugar * totalAmount
        foodHistoryResources.sumFoodSodium = foodDetailResource.foodSodium * totalAmount

        try? realm?.write {
            realm?.add(foodHistoryResources)
        }
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
    }

}
