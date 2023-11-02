//
//  BeerListViewController.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class BeerListViewController: UIViewController {
    
    @IBOutlet weak var beerTableView: UITableView!
    
    var data: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequestToBeer()
        configTableView()
        
    }
    
    func configTableView() {
        
        let nib = UINib(nibName: BeerTableViewCell.identifier, bundle: nil)
        beerTableView.register(nib, forCellReuseIdentifier: BeerTableViewCell.identifier)
        
        beerTableView.delegate = self
        beerTableView.dataSource = self
        
        beerTableView.rowHeight = 120
        
    }
    
    func callRequestToBeer() {
        
        let url = "https://api.punkapi.com/v2/beers"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
//                print(json)
                
                let beerArray = json.arrayValue
                for beer in beerArray {
                    let beerName = beer["name"].stringValue
                    let description = beer["description"].stringValue
                    
                    let imageUrlString = beer["image_url"].stringValue
                    
//                    print(beerName, description, imageUrlString)
                    
                    let beerData = Beer(name: beerName, description: description, imageString: imageUrlString)
                    self.data.append(beerData)
                    
                    self.beerTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

//MARK: - Extension for TableView

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = beerTableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier) as! BeerTableViewCell
        
        cell.beer = data[indexPath.row]
        
        return cell
    }
    
    
    
}
