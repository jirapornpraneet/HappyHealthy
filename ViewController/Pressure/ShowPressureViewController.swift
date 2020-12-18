//
//  ShowPressureViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 4/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ShowPressureViewController: UIViewController {

    @IBOutlet var datatimeLabel: UILabel!
    @IBOutlet var costPressureTopLabel: UILabel!
    @IBOutlet var costPressureDownLabel: UILabel!
    @IBOutlet var levelPressureImageView: UIImageView!
    @IBOutlet var levelPressureLabel: UILabel!
    @IBOutlet var warningPressureImageView: UIImageView!

    @IBOutlet var costHeartLabel: UILabel!
    @IBOutlet var levelHeartImageView: UIImageView!
    @IBOutlet var levelHeartLabel: UILabel!
    @IBOutlet var warningHeartImageView: UIImageView!

    var realm = try? Realm()
    var costTop: Int!
    var costDown: Int!
    var costPressureDown: Int!
    var costPressureTop: Int!
    var costHeartRate: Int!
    var colorsLevelPressure: [UIColor] = [UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0),
                                          UIColor(red: 0.87, green: 0.40, blue: 0.17, alpha: 1.0),
                                          UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0),
                                          UIColor(red: 0.96, green: 0.72, blue: 0.62, alpha: 1.0),
                                          UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0),
                                          UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)]

    var imagesLevelPressure: [UIImage]  = [UIImage(named: "levelPressure6.png")!,
                                           UIImage(named: "levelPressure5.png")!,
                                           UIImage(named: "levelPressure4.png")!,
                                           UIImage(named: "levelPressure3.png")!,
                                           UIImage(named: "levelPressure2.png")!,
                                           UIImage(named: "levelPressure1.png")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        let pressureResource = realm?.objects(PressureResource.self)
        costPressureTop = pressureResource?.last?.costPressureTop ?? 0
        costPressureDown = pressureResource?.last?.costPressureDown ?? 0
        costHeartRate = pressureResource?.last?.costHeartRate ?? 0

        datatimeLabel.text = pressureResource?.last?.dateTime
        costPressureTopLabel.text = String(format: "%i", pressureResource?.last?.costPressureTop ?? 0)
        costPressureDownLabel.text = String(format: "%i", pressureResource?.last?.costPressureDown ?? 0)
        levelPressureLabel.text = pressureResource?.last?.pressureLevel

        costHeartLabel.text = String(format: "%i", pressureResource?.last?.costHeartRate ?? 0)
        levelHeartLabel.text = pressureResource?.last?.heartRateLevel
        getPressure()
        getHeartRate()
    }

    func getPressure() {
        getPresureTop()
        getPresureDown()

        if costTop < costDown! {
            levelPressureLabel.backgroundColor = colorsLevelPressure[costTop]
            levelPressureImageView.image = imagesLevelPressure[costTop]
            if costTop == 0 {
                warningPressureImageView.image = R.image.warning()
            } else {
                warningPressureImageView.image = nil
            }
        } else {
            levelPressureLabel.backgroundColor = colorsLevelPressure[costDown]
            levelPressureImageView.image = imagesLevelPressure[costDown]
            if costDown == 0 {
                warningPressureImageView.image = R.image.warning()
            } else {
                warningPressureImageView.image = nil
            }
        }
    }

    func getPresureTop() {
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

    func getPresureDown() {
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

    func getHeartRate() {
        if costHeartRate >= 101 {
            warningHeartImageView.image = R.image.warning()
            levelHeartImageView.image = R.image.levelHeart5()
            levelHeartLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
        } else if costHeartRate >= 85 && costHeartRate < 101 {
            warningHeartImageView.image = nil
            levelHeartImageView.image = R.image.levelHeart4()
            levelHeartLabel.backgroundColor = UIColor(red: 0.87, green: 0.40, blue: 0.17, alpha: 1.0)
        } else if costHeartRate >= 70 && costHeartRate < 85 {
            warningHeartImageView.image = nil
            levelHeartImageView.image = R.image.levelHeart3()
            levelHeartLabel.backgroundColor = UIColor(red: 0.96, green: 0.72, blue: 0.62, alpha: 1.0)
        } else if costHeartRate >= 60 && costHeartRate < 70 {
            warningHeartImageView.image = nil
            levelHeartImageView.image = R.image.levelHeart2()
            levelHeartLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
        } else if costHeartRate >= 41 && costHeartRate < 60 {
            warningHeartImageView.image = nil
            levelHeartImageView.image = R.image.levelHeart1()
            levelHeartLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
        } else {
            warningHeartImageView.image = R.image.warning()
            levelHeartImageView.image = R.image.levelHeart5()
            levelHeartLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
        }
    }
}
