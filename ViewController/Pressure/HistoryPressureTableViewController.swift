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
        return pressureResource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let pressureResources = pressureResource?[indexPath.row] {
                try? realm?.write {realm?
                    .delete((realm?.objects(PressureResource.self)
                        .filter("pressureId = %@",
                                pressureResources.pressureId))!)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
