//
//  FoodViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 7/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var nameFoodLabel: UILabel!
    @IBOutlet weak var kcalFoodLabel: UILabel!
    @IBOutlet weak var detailFoodLabel: UILabel!
    @IBOutlet weak var unitFoodLabel: UILabel!
}

class FoodTableViewController: UITableViewController, UISearchBarDelegate,
UISearchDisplayDelegate {

    @IBOutlet var searchBar: UISearchBar!

    var realm = try? Realm()
    var foodResources: Results<FoodResource>!
    var listedFoods: Results<FoodResource>!
    var indexRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        foodResources = realm?.objects(FoodResource.self)
        listedFoods = foodResources
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listedFoods.count == 0 {
            return 1
        }
        return listedFoods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNotFound = UITableViewCell.init()
        cellNotFound.textLabel?.text = "ไม่มีข้อมูล"
        cellNotFound.textLabel?.textAlignment = .center
        if listedFoods.count == 0 {
            return cellNotFound
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.foodCells,
                                                 for: indexPath as IndexPath)!
        let cellData = listedFoods[indexPath.row]
        cell.nameFoodLabel.text = cellData.foodName
        cell.kcalFoodLabel.text = String(format: "%.02f", (cellData.foodCalories))
        cell.detailFoodLabel.text = cellData.foodDetail
        cell.unitFoodLabel.text = String(format: "1  %@", cellData.foodUnit!)
        cell.layoutIfNeeded()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        indexRow = indexPath.row
        self.performSegue(withIdentifier: R.segue.foodTableViewController.foodDetail, sender: self)
    }

    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typedInfo = R.segue.foodTableViewController.foodDetail(segue: segue) {
            typedInfo.destination.foodDetailResource = listedFoods[indexRow]
        }
    }

    // MARK: - UISearchDisplayDelegate

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        listedFoods = foodResources
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchBar.showsCancelButton = false
            listedFoods = foodResources
            tableView.reloadData()
            return
        }

        searchBar.showsCancelButton = true
        doSearch(searchText: searchText.lowercased())
    }

    func doSearch(searchText: String) {
        let predicate = NSPredicate(format: "foodName BEGINSWITH [c]%@", searchText)
        listedFoods = self.realm?.objects(FoodResource.self)
            .filter(predicate)
            .sorted(byKeyPath: "foodName", ascending: true)
        tableView.reloadData()
    }

}
