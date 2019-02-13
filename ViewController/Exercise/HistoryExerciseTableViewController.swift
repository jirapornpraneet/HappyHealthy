//
//  HistoryExerciseTableViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 13/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var nameExerciseLabel: UILabel!
    @IBOutlet weak var kcalExerciseLabel: UILabel!
    @IBOutlet weak var diseaseExerciseLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
}

class HistoryExerciseTableViewController: UITableViewController, UISearchBarDelegate,
UISearchDisplayDelegate {

    @IBOutlet var searchBar: UISearchBar!

    var realm = try? Realm()
    var historyExerciseResources: Results<ExerciseHistoryResource>!
    var listedHistoryExercises: Results<ExerciseHistoryResource>!
    var dateTime: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        print("RealmTest\(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        let predicate = NSPredicate(format: "historyExerciseDate = %@", dateTime as CVarArg)
        let exerciseHistoryResources = self.realm!.objects(ExerciseHistoryResource.self).filter(predicate)
        historyExerciseResources = exerciseHistoryResources
        listedHistoryExercises = historyExerciseResources
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listedHistoryExercises.count == 0 {
            return 1
        }
        return listedHistoryExercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNotFound = UITableViewCell.init()
        cellNotFound.textLabel?.text = "ไม่มีข้อมูล"
        cellNotFound.textLabel?.textAlignment = .center
        if listedHistoryExercises.count == 0 {
            return cellNotFound
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyExerciseCells,
                                                 for: indexPath as IndexPath)!
        let cellData = listedHistoryExercises[indexPath.row]
        cell.dateTimeLabel.text = String(format: "ข้อมูลวันที่  %@", dateTime)
        cell.nameExerciseLabel.text = cellData.exerciseName
        cell.kcalExerciseLabel.text = String(format: "%.02f", cellData.sumExerciseCalories)
        cell.diseaseExerciseLabel.text = cellData.exerciseDisease
        cell.totalDurationLabel.text = String(format: "ต่อ  %.02f  เซท", cellData.exerciseTotalSet)
        cell.layoutIfNeeded()
        return cell
    }

    // MARK: - UISearchDisplayDelegate

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        listedHistoryExercises = historyExerciseResources
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchBar.showsCancelButton = false
            listedHistoryExercises = historyExerciseResources
            tableView.reloadData()
            return
        }
        searchBar.showsCancelButton = true
        doSearch(searchText: searchText.lowercased())
    }

    func doSearch(searchText: String) {
        let predicate = NSPredicate(format: "exerciseName BEGINSWITH [c]%@", searchText)
        listedHistoryExercises = self.realm?.objects(ExerciseHistoryResource.self)
            .filter(predicate)
            .sorted(byKeyPath: "exerciseName", ascending: true)
        tableView.reloadData()
    }
}
