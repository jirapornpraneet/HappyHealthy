//
//  ShowKidneyViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 1/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ShowKidneyViewController: UIViewController {

    @IBOutlet var levelKidneyImageView: UIImageView!
    @IBOutlet var datatimeLabel: UILabel!
    @IBOutlet var costGFRLabel: UILabel!
    @IBOutlet var levelKidneyLabel: UILabel!
    @IBOutlet var warningImageView: UIImageView!

    var realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        getKidney()
    }

    func getKidney() {
        let kidneyResource = realm?.objects(KidneyResrouce.self)
        let costGFR: Int = kidneyResource?.last?.costGFR ?? 0

        if costGFR >= 90 {
            warningImageView.image = nil
            levelKidneyLabel.backgroundColor = UIColor(red: 0.50, green: 0.93, blue: 0.05, alpha: 1.0)
            levelKidneyImageView.image = R.image.levelKidney1()
        } else if costGFR >= 60 && costGFR < 90 {
            warningImageView.image = nil
            levelKidneyImageView.image = R.image.levelKidney2()
            levelKidneyLabel.backgroundColor = UIColor(red: 0.95, green: 0.84, blue: 0.35, alpha: 1.0)
        } else if costGFR >= 30 && costGFR < 60 {
            warningImageView.image = nil
            levelKidneyImageView.image = R.image.levelKidney3()
            levelKidneyLabel.backgroundColor = UIColor(red: 0.93, green: 0.70, blue: 0.58, alpha: 1.0)
        } else if costGFR >= 15 && costGFR < 30 {
            warningImageView.image = nil
            levelKidneyImageView.image = R.image.levelKidney4()
            levelKidneyLabel.backgroundColor = UIColor(red: 0.92, green: 0.55, blue: 0.39, alpha: 1.0)
        } else {
            warningImageView.image = R.image.warning()
            levelKidneyImageView.image = R.image.levelKidney5()
            levelKidneyLabel.backgroundColor = UIColor(red: 0.96, green: 0.28, blue: 0.28, alpha: 1.0)
        }

        datatimeLabel.text = kidneyResource?.last?.dateTime
        costGFRLabel.text = String(format: "%i", kidneyResource?.last?.costGFR ?? 0)
        levelKidneyLabel.text = kidneyResource?.last?.kidneyLevel
    }
}
