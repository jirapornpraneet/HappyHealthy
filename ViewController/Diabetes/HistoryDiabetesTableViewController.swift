//
//  HistoryDiabetesTableViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 24/1/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryDiabetesTableViewCell: UITableViewCell {
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var costSugarLabel: UILabel!
    @IBOutlet var levelDiabetesLabel: UILabel!
    @IBOutlet var statusEatingLabel: UILabel!
}

class HistoryDiabetesTableViewController: UITableViewController {

    var realm = try? Realm()
    var diabetesResource: Results<DiabetesResrouce>!

    override func viewDidLoad() {
        super.viewDidLoad()
        diabetesResource = realm?.objects(DiabetesResrouce.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diabetesResource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyDiabetesCells,
                                                 for: indexPath as IndexPath)!
        let cellData = diabetesResource[indexPath.row]
        cell.dateTimeLabel.text = cellData.dateTime
        cell.costSugarLabel.text = String(format: "%i", cellData.costSugar)
        cell.levelDiabetesLabel.text = cellData.diabetesLevel
        cell.statusEatingLabel.text = cellData.statusEating
        cell.layoutIfNeeded()
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let diabetesResources = diabetesResource?[indexPath.row] {
                try? realm?.write {realm?
                    .delete((realm?.objects(DiabetesResrouce.self)
                        .filter("diabetesId = %@",
                                diabetesResources.diabetesId))!)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
