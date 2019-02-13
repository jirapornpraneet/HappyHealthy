//
//  ExerciseDetailViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 12/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var nameExerciseLabel: UILabel!
    @IBOutlet weak var descriptionExerciseLabel: UILabel!
    @IBOutlet weak var kcalExerciseLabel: UILabel!
    @IBOutlet weak var detailExerciseLabel: UILabel!
    @IBOutlet weak var diseaseExerciseLabel: UILabel!
    @IBOutlet weak var durationExerciseTextField: UITextField!

    var exerciseDetailResource: ExerciseResource!
    var exerciseResource: ExerciseResource!
    var totalDuration: Double!
    var realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataExerciseDetail()
    }

    func getDataExerciseDetail() {
        totalDuration = 1.0
        nameExerciseLabel.text = exerciseDetailResource.exerciseName
        kcalExerciseLabel.text = String(format: "%.02f", exerciseDetailResource.exerciseCalories)
        descriptionExerciseLabel.text = exerciseDetailResource.exerciseDescription
        detailExerciseLabel.text = exerciseDetailResource.exerciseDetail
        diseaseExerciseLabel.text = exerciseDetailResource.exerciseDisease
        durationExerciseTextField.text = String(format: "%.02f", totalDuration)
    }

    @IBAction func durationExerciseTextFieldEditingChanged(_ sender: Any) {
        if durationExerciseTextField.text == "" {
            return
        }

        totalDuration = 1.0
        totalDuration = Double(durationExerciseTextField.text ?? "")
        setDataDetailExercise(totalDuration: totalDuration)
    }

    func setDataDetailExercise(totalDuration: Double) {
        nameExerciseLabel.text = exerciseDetailResource.exerciseName
        kcalExerciseLabel.text = String(format: "%.02f", exerciseDetailResource.exerciseCalories * totalDuration)
        descriptionExerciseLabel.text = exerciseDetailResource.exerciseDescription
        detailExerciseLabel.text = exerciseDetailResource.exerciseDetail
        diseaseExerciseLabel.text = exerciseDetailResource.exerciseDisease
    }

    @IBAction func saveDataHistoryExercise(_ sender: Any) {
        let alertShow = UIAlertController (title: "ยืนยันการบันทึกออกกำลังกาย",
                                           message: "คุณแน่ใจใช่ไหม",
                                           preferredStyle: UIAlertController.Style.alert)
        alertShow.addAction(UIAlertAction(title: "บันทึก",
                                          style: UIAlertAction.Style.default,
                                          handler: { (_) in
                                            alertShow.dismiss(animated: true, completion: nil)
                                            self.addDataHistoryExercise()
                                            self.navigationController?.popViewController(animated: true)
        }))
        alertShow.addAction(UIAlertAction(title: "ยกเลิก",
                                          style: UIAlertAction.Style.default,
                                          handler: { (_) in
            alertShow.dismiss(animated: true, completion: nil)
        }))
        self.present(alertShow, animated: true, completion: nil)
    }

    func addDataHistoryExercise() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let saveDate = formatter.string(from: date)
        let exerciseHistoryResource = realm?.objects(ExerciseHistoryResource.self)
        let exerciseHistoryResources = ExerciseHistoryResource()

        if exerciseHistoryResource?.count == 0 {
            exerciseHistoryResources.historyExerciseId = 1
        } else {
            exerciseHistoryResources.historyExerciseId = (exerciseHistoryResource?.last!.historyExerciseId)! + 1
        }

        exerciseHistoryResources.historyExerciseDate = saveDate
        exerciseHistoryResources.exerciseId = exerciseDetailResource.exerciseId
        exerciseHistoryResources.exerciseName = exerciseDetailResource.exerciseName
        exerciseHistoryResources.exerciseDisease = exerciseDetailResource.exerciseDisease
        exerciseHistoryResources.exerciseTotalDuration = totalDuration
        exerciseHistoryResources.sumExerciseCalories = exerciseDetailResource.exerciseCalories * totalDuration

        try? realm?.write {
            realm?.add(exerciseHistoryResources)
        }
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
    }
}
