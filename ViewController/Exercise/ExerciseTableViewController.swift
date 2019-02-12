//
//  ExerciseTableViewController.swift
//  HappyHealthy
//
//  Created by Jiraporn Praneet on 12/2/2562 BE.
//  Copyright © 2562 jirapornpraneetHappyHealthy. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var nameExerciseLabel: UILabel!
    @IBOutlet weak var kcalExerciseLabel: UILabel!
    @IBOutlet weak var diseaseExerciseLabel: UILabel!
}

class ExerciseTableViewController: UITableViewController, UISearchBarDelegate,
UISearchDisplayDelegate {

    @IBOutlet var searchBar: UISearchBar!

    var realm = try? Realm()
    var exerciseResources: Results<ExerciseResource>!
    var listedExercises: Results<ExerciseResource>!
    var indexRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseResources = realm?.objects(ExerciseResource.self)
        listedExercises = exerciseResources
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listedExercises.count == 0 {
            return 1
        }
        return listedExercises.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNotFound = UITableViewCell.init()
        cellNotFound.textLabel?.text = "ไม่มีข้อมูล"
        cellNotFound.textLabel?.textAlignment = .center
        if listedExercises.count == 0 {
            return cellNotFound
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.exerciseCells,
                                                 for: indexPath as IndexPath)!
        let cellData = listedExercises[indexPath.row]
        cell.nameExerciseLabel.text = cellData.exerciseName
        cell.kcalExerciseLabel.text = String(format: "%.02f", (cellData.exerciseCalories))
        cell.diseaseExerciseLabel.text = cellData.exerciseDisease
        cell.layoutIfNeeded()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        indexRow = indexPath.row
        self.performSegue(withIdentifier: R.segue.exerciseTableViewController.exerciseDetail, sender: self)
    }

    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typedInfo = R.segue.exerciseTableViewController.exerciseDetail(segue: segue) {
            typedInfo.destination.exerciseDetailResource = listedExercises[indexRow]
        }
    }

    // MARK: - UISearchDisplayDelegate

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        listedExercises = exerciseResources
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchBar.showsCancelButton = false
            listedExercises = exerciseResources
            tableView.reloadData()
            return
        }

        searchBar.showsCancelButton = true
        doSearch(searchText: searchText.lowercased())
    }

    func doSearch(searchText: String) {
        let predicate = NSPredicate(format: "exerciseName BEGINSWITH [c]%@", searchText)
        listedExercises = self.realm?.objects(ExerciseResource.self)
            .filter(predicate)
            .sorted(byKeyPath: "exerciseName", ascending: true)
        tableView.reloadData()
    }
}
