//
//  ListConfigurationHomeViewController.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/14.
//

import UIKit
import SnapKit

class ListConfigurationHomeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return view
    }()
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "검색어를 입력해주세요"
        return bar
    }()
    
//    let imageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = 20
//        return iv
//    }()

    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult>!
    
    let viewModel = ListConfigurationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        searchBar.delegate = self
        
//        view.addSubview(imageView)
                
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
//        imageView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom)
//            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(100)
//        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
//            make.top.equalTo(imageView.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    
        //searchbar 입력으로 입력할 단어값 update 시 실행할 closure
        viewModel.searchQuery.bind { word in
            print("Starts getting data from API")
            self.viewModel.callRequest(query: word)
        }
        
        //callRequest로 API로부터 data 얻어와서 update될 시 실행할 closure
        viewModel.photoResults.bind { _ in
            print("starts reload collectionView")
            //아직까지 DispatchQueue.global()
            //UI update는 main에서
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            print("cellRegistration called!!!")
            var content = UIListContentConfiguration.valueCell()
        
            self.viewModel.getImageFromNetwork(url: itemIdentifier.urls.thumb) { image in
                content.image = image
//                self.imageView.image = image
            }
            
            
            content.text = itemIdentifier.user.username
            content.secondaryText = itemIdentifier.description
        
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            content.secondaryTextProperties.font = .systemFont(ofSize: 12, weight: .medium)
            
            cell.contentConfiguration = content
        })
        
    }
    
    
    //setup compositionalLayout with listConfiguration
    func createCompositionalLayout() -> UICollectionViewLayout {
        var listConfig = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfig.backgroundColor = .lightGray
        let layout = UICollectionViewCompositionalLayout.list(using: listConfig)
        return layout
    }
    

}

//MARK: - Extension for CollectionView Delegate, DataSource

extension ListConfigurationHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return viewModel.numberOfItemsInSection()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        
        guard let data = viewModel.cellForItemData(indexPath: indexPath) else {
            print("Can't get data from viewModel")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data)
        return cell
    }
    
}

//MARK: - Extension for SearchBar Delegate

extension ListConfigurationHomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let searchQuery = searchBar.text else { return }
        print("searchQuery: ", searchQuery)
        viewModel.searchQuery.value = searchQuery
    }
    
}
