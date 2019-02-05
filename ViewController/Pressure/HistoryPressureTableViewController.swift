//
//  HistoryPressureTableViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 5/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryPressureTableViewCell: UITableViewCell {
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var costPressureTopLabel: UILabel!
    @IBOutlet var costPressureDownLabel: UILabel!
    @IBOutlet var levelPressureLabel: UILabel!
    @IBOutlet var costHeartLabel: UILabel!
    @IBOutlet var levelHeartLabel: UILabel!
}

class HistoryPressureTableViewController: UITableViewController {

    var realm = try? Realm()
    var pressureResource: Results<PressureResource>!

    override func viewDidLoad() {
        super.viewDidLoad()
        pressureResource = realm?.objects(PressureResource.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pressureResource.count == 0 {
            return 1
        }
        return pressureResource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNotFound = UITableViewCell.init()
        cellNotFound.textLabel?.text = "ไม่มีข้อมูล"
        cellNotFound.textLabel?.textAlignment = .center
        if pressureResource.count == 0 {
            return cellNotFound
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyPressureCells,
                                                 for: indexPath as IndexPath)!
        let cellData = pressureResource[indexPath.row]
        cell.dateTimeLabel.text = cellData.dateTime
        cell.costPressureTopLabel.text = String(format: "%i", cellData.costPressureTop)
        cell.costPressureDownLabel.text = String(format: "%i", cellData.costPressureDown)
        cell.levelPressureLabel.text = cellData.pressureLevel
        cell.costHeartLabel.text = String(format: "%i", cellData.costHeartRate)
        cell.levelHeartLabel.text = cellData.heartRateLevel
        cell.layoutIfNeeded()
        return cell
    }
}
