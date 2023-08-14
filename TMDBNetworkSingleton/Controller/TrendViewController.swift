//
//  ViewController.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialMovie()
    }

    func setupInitialMovie() {
        
        //with decodable
        dataManager.setMovieTrendListWithDecodableStruct(type: .trendMovie, page: 1) {
            print("Data setup is done")
            self.configNavBar()
            self.configCollectionView()
        }
        
//        dataManager.setMovieTrendList(type: .trendMovie, page: 1) {
//            print("Data setup is done")
//            self.configNavBar()
//            self.configCollectionView()
//        }
    }
    
    func configCollectionView() {
        let nib = UINib(nibName: ContentCell.identifier, bundle: nil)
        contentCollectionView.register(nib, forCellWithReuseIdentifier: ContentCell.identifier)
        
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.prefetchDataSource = self
        
        configCollectionViewFlowLayout()
    }
    
    func configCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 10
        
        let width = UIScreen.main.bounds.width - 2 * spacing
        
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        contentCollectionView.collectionViewLayout = layout
    }
    
    

}

//MARK: - Extension for CollectionView Delegate, DataSource,

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("row number: \(dataManager.getContentsList().count)")
        return dataManager.getContentsList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.identifier, for: indexPath) as! ContentCell
        
        cell.movie = dataManager.getContentsList()[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let creditVC = sb.instantiateViewController(withIdentifier: CreditViewController.identifier) as! CreditViewController
        
        creditVC.movie = dataManager.getContentsList()[indexPath.row]
        
        navigationController?.pushViewController(creditVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            if dataManager.getContentsList().count - 1 == indexPath.row {
                dataManager.addPageNum()
                
                dataManager.setMovieTrendListWithDecodableStruct(type: .trendMovie, page: dataManager.getPageNum()) {
                    //data 새로 가져온 후, collectionView 갱신
                    self.contentCollectionView.reloadData()
                }
            
//                dataManager.setMovieTrendList(type: .trendMovie, page: dataManager.getPageNum()) {
//                    //data 새로 가져온 후, collectionView 갱신
//                    self.contentCollectionView.reloadData()
//                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("Cancel: \(indexPaths)")
    }
    
    
}

//MARK: - Extension for UI

extension TrendViewController {
    
    func configNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listBarButtonItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBarButtonItemTapped))
    }
    
    
    //MARK: - Handlers
    
    @objc func listBarButtonItemTapped() {
        print("left bar button item tapped")
    }
    
    @objc func searchBarButtonItemTapped() {
        print("right bar button item tapped")
    }
}



