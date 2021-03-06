//
//  HistoryFoodTableViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 12/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryFoodTableViewCell: UITableViewCell {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var nameFoodLabel: UILabel!
    @IBOutlet weak var kcalFoodLabel: UILabel!
    @IBOutlet weak var detailFoodLabel: UILabel!
    @IBOutlet weak var unitFoodLabel: UILabel!
}

class HistoryFoodTableViewController: UITableViewController, UISearchBarDelegate,
UISearchDisplayDelegate {

    @IBOutlet var searchBar: UISearchBar!

    var realm = try? Realm()
    var historyFoodResources: Results<FoodHistoryResource>!
    var listedHistoryFoods: Results<FoodHistoryResource>!
    var dateTime: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        let predicate = NSPredicate(format: "historyFoodDate = %@", dateTime as CVarArg)
        let foodHistoryResources = self.realm!.objects(FoodHistoryResource.self).filter(predicate)
        historyFoodResources = foodHistoryResources
        listedHistoryFoods = historyFoodResources
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listedHistoryFoods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyFoodCells,
                                                 for: indexPath as IndexPath)!
        let cellData = listedHistoryFoods[indexPath.row]
        cell.dateTimeLabel.text = String(format: "ข้อมูลวันที่  %@", dateTime)
        cell.nameFoodLabel.text = cellData.foodName
        cell.kcalFoodLabel.text = String(format: "%.02f", cellData.sumFoodCalories)
        cell.detailFoodLabel.text = cellData.foodDetail
        cell.unitFoodLabel.text = String(format: "%.02f  %@", cellData.foodTotalAmount, cellData.foodUnit!)
        cell.layoutIfNeeded()
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let foodHistoryResources = listedHistoryFoods?[indexPath.row] {
                try? realm?.write {realm?
                    .delete((realm?.objects(FoodHistoryResource.self)
                        .filter("historyFoodId = %@",
                                foodHistoryResources.historyFoodId))!)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }

    // MARK: - UISearchDisplayDelegate

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        listedHistoryFoods = historyFoodResources
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchBar.showsCancelButton = false
            listedHistoryFoods = historyFoodResources
            tableView.reloadData()
            return
        }
        searchBar.showsCancelButton = true
        doSearch(searchText: searchText.lowercased())
    }

    func doSearch(searchText: String) {
        let predicate = NSPredicate(format: "foodName BEGINSWITH [c]%@", searchText)
        listedHistoryFoods = self.realm?.objects(FoodHistoryResource.self)
            .filter(predicate)
            .sorted(byKeyPath: "foodName", ascending: true)
        tableView.reloadData()
    }
}
