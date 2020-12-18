//
//  ReportFoodandExerciseViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 12/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import AAPickerView
import RealmSwift

class ReportFoodandExerciseViewController: UIViewController {

    @IBOutlet weak var exerciseTotalCaloriesLabel: UILabel!
    @IBOutlet weak var foodTotalCaloriesLabel: UILabel!
    @IBOutlet weak var dateTimePicker: AAPickerView!
    @IBOutlet weak var sumProtinLabel: UILabel!
    @IBOutlet weak var sumCarbohydateLabel: UILabel!
    @IBOutlet weak var sumFatLabel: UILabel!
    @IBOutlet weak var sumSugarLabel: UILabel!
    @IBOutlet weak var sumSodiumLabel: UILabel!
    @IBOutlet weak var sumTotalCaloriesLabel: UILabel!

    var realm = try? Realm()
    var saveDate: String = ""
    var sumTotalFoodCalories = 0.0
    var sumTotalExerciseCalories = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let setDate = formatter.string(from: date)
        saveDate = setDate
        getDataFoodHistory()
        getDataExerciseHistory()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "รายงานการบริโภคและการออกกำลังกาย"
        configPicker()
        getDataFoodHistory()
        getDataExerciseHistory()
        getTotalCalories()
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
            self.getDataFoodHistory()
            self.getDataExerciseHistory()
            self.getTotalCalories()
        }
    }

    func getDataFoodHistory() {
        let predicate = NSPredicate(format: "historyFoodDate = %@", self.saveDate as CVarArg)
        let foodHistoryResources = self.realm!.objects(FoodHistoryResource.self).filter(predicate)

        var sumProtin = 0.0
        var sumCarbohydate = 0.0
        var sumFat = 0.0
        var sumSugar = 0.0
        var sumSodium = 0.0
        var sumCalories = 0.0

        if foodHistoryResources.count == 0 {
            foodTotalCaloriesLabel.text = String(format: "%.02f", 0.0)
            sumProtinLabel.text = String(format: "%.02f", 0.0)
            sumCarbohydateLabel.text = String(format: "%.02f", 0.0)
            sumFatLabel.text = String(format: "%.02f", 0.0)
            sumSugarLabel.text = String(format: "%.02f", 0.0)
            sumSodiumLabel.text = String(format: "%.02f", 0.0)
            sumTotalFoodCalories = 0.0
            return
        }

        for item in 0...foodHistoryResources.count - 1 {
            let foodHistoryResource = foodHistoryResources[item]
            sumCalories += foodHistoryResource.sumFoodCalories
            sumProtin += foodHistoryResource.sumFoodProtein
            sumCarbohydate += foodHistoryResource.sumFoodCarbohydrate
            sumFat += foodHistoryResource.sumFoodFat
            sumSugar += foodHistoryResource.sumFoodSugar
            sumSodium += foodHistoryResource.sumFoodSodium
        }

        sumTotalFoodCalories = sumCalories
        foodTotalCaloriesLabel.text = String(format: "%.02f", sumCalories)
        sumProtinLabel.text = String(format: "%.02f", sumProtin)
        sumCarbohydateLabel.text = String(format: "%.02f", sumCarbohydate)
        sumFatLabel.text = String(format: "%.02f", sumFat)
        sumSugarLabel.text = String(format: "%.02f", sumSugar)
        sumSodiumLabel.text = String(format: "%.02f", sumSodium)
    }

    func getDataExerciseHistory() {
        let predicate = NSPredicate(format: "historyExerciseDate = %@", self.saveDate as CVarArg)
        let exerciseHistoryResources = self.realm!.objects(ExerciseHistoryResource.self).filter(predicate)

        var sumExerciseCalories = 0.0

        if exerciseHistoryResources.count == 0 {
            exerciseTotalCaloriesLabel.text = String(format: "%.02f", 0.0)
            sumTotalExerciseCalories = 0.0
            return
        }

        for item in 0...exerciseHistoryResources.count - 1 {
            let exerciseHistoryDateResource = exerciseHistoryResources[item]
            sumExerciseCalories += exerciseHistoryDateResource.sumExerciseCalories
        }

        sumTotalExerciseCalories = sumExerciseCalories
        exerciseTotalCaloriesLabel.text = String(format: "%.02f", sumExerciseCalories)
    }

    func getTotalCalories() {
        let sumTotalCalories = sumTotalFoodCalories - sumTotalExerciseCalories
        sumTotalCaloriesLabel.text = String(format: "%.02f", sumTotalCalories)
    }

    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typedInfo = R.segue.reportFoodandExerciseViewController.showHistoryFood(segue: segue) {
            typedInfo.destination.dateTime = saveDate
        } else if  let typedInfo2 = R.segue.reportFoodandExerciseViewController.showHistoryExercise(segue: segue) {
            typedInfo2.destination.dateTime = saveDate
        }
    }
}
