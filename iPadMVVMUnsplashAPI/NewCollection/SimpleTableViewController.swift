//
//  SimpleTableViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/14.
//

import UIKit

//protocol 채택 별도 설정 필요는 없음
class SimpleTableViewController: UITableViewController {
    
    private var list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()

        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].name
        content.secondaryText = "\(list[indexPath.row].age)"

        //content 내 여러 Property에 접근, 설정하기
        //configuration을 해당 UI component에 할당/적용하기
        
        cell.contentConfiguration = content
        return cell
        
    }
    
    
}
