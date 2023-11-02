//
//  SimpleTableViewController.swift
//  RxSampleProjects
//
//  Created by Heedon on 2023/10/31.
//

import UIKit

import RxSwift
import RxCocoa

class SimpleTableViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        operatorJustExample()
//        operatorOfExample()
//        operatorFromExample()
    }
    
    func operatorJustExample() {
        
        //cell register 필요
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )

        //
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)


        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                print("Tapped `\(value)`")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
    

    func operatorOfExample() {
        
    }
    
    func operatorFromExample() {
        
    }

}
