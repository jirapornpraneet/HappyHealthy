//
//  ShowDiabetesViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 24/1/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ShowDiabetesViewController: UIViewController {

    @IBOutlet var levelDiabetesImageView: UIImageView!
    @IBOutlet var datatimeLabel: UILabel!
    @IBOutlet var costSugarLabel: UILabel!
    @IBOutlet var levelDiabetesLabel: UILabel!
    @IBOutlet var warningImageView: UIImageView!

    var realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataDiabetes()
    }

    func getDataDiabetes() {
        let diabetesResource = realm?.objects(DiabetesResrouce.self)
        let userResource = realm?.objects(UserResource.self)
        let isDiabetes = userResource?.last?.isDiabetes
        let costSugar: Int = diabetesResource?.last?.costSugar ?? 0
        let statusEating: String = diabetesResource?.last?.statusEating ?? "ก่อนอาหาร"

        if isDiabetes == false {
            if statusEating == "ก่อนอาหาร" {
                if costSugar >= 126 {
                    warningImageView.image = R.image.warning()
                    levelDiabetesImageView.image = R.image.levelNormal1()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 126 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelNormal2()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningImageView.image = R.image.warning()
                    levelDiabetesImageView.image = R.image.levelNormal1()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            } else {
                if costSugar >= 200 {
                    warningImageView.image = R.image.warning()
                    levelDiabetesImageView.image = R.image.levelNormal1()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 200 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelNormal2()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningImageView.image = R.image.warning()
                    levelDiabetesImageView.image = R.image.levelNormal1()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            }
        } else {
            if statusEating == "ก่อนอาหาร" {
                if costSugar >= 130 {
                    warningImageView.image = R.image.warning()
                    levelDiabetesImageView.image = R.image.levelDiabetes4()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 100 && costSugar < 130 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes3()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0)
                } else if costSugar >= 90 && costSugar < 100 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes2()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 90 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes1()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes4()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            } else {
                if costSugar >= 180 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes4()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                } else if costSugar >= 150 && costSugar < 180 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes3()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0)
                } else if costSugar >= 110 && costSugar < 150 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes2()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
                } else if costSugar >= 70 && costSugar < 110 {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes1()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
                } else {
                    warningImageView.image = nil
                    levelDiabetesImageView.image = R.image.levelDiabetes4()
                    levelDiabetesLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
                }
            }
        }

        datatimeLabel.text = diabetesResource?.last?.dateTime
        costSugarLabel.text = String(format: "%i", diabetesResource?.last?.costSugar ?? 0)
        levelDiabetesLabel.text = diabetesResource?.last?.diabetesLevel
    }

}
