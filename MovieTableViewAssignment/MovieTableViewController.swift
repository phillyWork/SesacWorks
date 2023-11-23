//
//  MovieTableViewController.swift
//  MovieTableViewAssignment
//
//  Created by Heedon on 2023/07/28.
//

import UIKit

class MovieTableViewController: UITableViewController {

    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 200
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataManager.getData().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        
        cell.configCell(cell: indexPath.row)
        
        return cell
    }

}
