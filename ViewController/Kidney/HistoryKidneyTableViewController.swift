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
        if kidneyResource.count == 0 {
            return 1
        }
        return kidneyResource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNotFound = UITableViewCell.init()
        cellNotFound.textLabel?.text = "ไม่มีข้อมูล"
        cellNotFound.textLabel?.textAlignment = .center
        if kidneyResource.count == 0 {
            return cellNotFound
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyKidneyCells,
                                                 for: indexPath as IndexPath)!
        let cellData = kidneyResource[indexPath.row]
        cell.dateTimeLabel.text = cellData.dateTime
        cell.costGFRLabel.text = String(format: "%i", cellData.costGFR)
        cell.levelKidneyLabel.text = cellData.kidneyLevel
        cell.layoutIfNeeded()
        return cell
    }
}
