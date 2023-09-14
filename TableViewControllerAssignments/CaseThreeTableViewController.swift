//
//  CaseThreeTableViewController.swift
//  TableViewControllerAssignments
//
//  Created by Heedon on 2023/07/27.
//

import UIKit

class CaseThreeTableViewController: UITableViewController {

    @IBOutlet var inputTextField: UITextField!
    
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 50
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getWorkToDo().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "caseThreeCell")!
        
        cell.textLabel?.text = dataManager.getWorkToDo()[indexPath.row]
        cell.detailTextLabel?.text = dataManager.getStars()[0]
        cell.detailTextLabel?.font = .systemFont(ofSize: 20)
        cell.imageView?.image = UIImage(systemName: "checkmark.square")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        let beforeStar = Star(rawValue: (cell.detailTextLabel?.text)!)
        cell.detailTextLabel?.text = beforeStar?.afterSelection
        
        cell.imageView?.image = cell.imageView?.image == UIImage(systemName: "checkmark.square") ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
    }

    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        if inputTextField.hasText {
            dataManager.addWorkData(chore: inputTextField.text!)
        }
        tableView.reloadData()
    }
    
    

}
