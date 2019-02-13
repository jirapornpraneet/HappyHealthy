//
//  HistoryKidneyTableViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 4/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryKidneyTableViewCell: UITableViewCell {
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var costGFRLabel: UILabel!
    @IBOutlet var levelKidneyLabel: UILabel!
}

class HistoryKidneyTableViewController: UITableViewController {

    var realm = try? Realm()
    var kidneyResource: Results<KidneyResrouce>!

    override func viewDidLoad() {
        super.viewDidLoad()
        kidneyResource = realm?.objects(KidneyResrouce.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kidneyResource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyKidneyCells,
                                                 for: indexPath as IndexPath)!
        let cellData = kidneyResource[indexPath.row]
        cell.dateTimeLabel.text = cellData.dateTime
        cell.costGFRLabel.text = String(format: "%i", cellData.costGFR)
        cell.levelKidneyLabel.text = cellData.kidneyLevel
        cell.layoutIfNeeded()
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let kidneyResources = kidneyResource?[indexPath.row] {
                try? realm?.write {realm?
                    .delete((realm?.objects(KidneyResrouce.self)
                        .filter("kidneyId = %@",
                                kidneyResources.kidneyId))!)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
