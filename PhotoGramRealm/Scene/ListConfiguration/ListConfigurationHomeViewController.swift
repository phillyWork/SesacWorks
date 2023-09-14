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
    
    let dispatchGroup = DispatchGroup()
    var refCount = 0
    
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
//            make.top.equalTo(imageView.snp.bottom)
            make.top.equalTo(searchBar.snp.bottom)
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
           
            //cell creation 완료 이후 각 cell의 image 가져옴 ~ 비동기처리
            //임시 방안: 가져온 PhotoResult마다 imageUrl을 다시 network 통신 요청 (with dispatchgroup)
            for photo in self.viewModel.photoResults.value! {
                self.dispatchGroup.enter()
                self.viewModel.getImageFromNetwork(url: photo.urls.thumb) { image in
                    self.viewModel.imageLists.append(image)
                    self.dispatchGroup.leave()
                }
            }
            
            //해당 이미지 다 가져오면 그 때 collectionView reloadData
            //예상 문제: 네트워크 실패하는 경우: 이미지 개수만큼 다 못 가져옴 ~ 못 가져올 경우: default image 활용하기 (not_image_avaialble 같은...)
            self.dispatchGroup.notify(queue: .main) {
                self.collectionView.reloadData()
            }
                       
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
        }
        
        self.cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            print("cellRegistration called in \(Thread.current)!!!")

            var content = UIListContentConfiguration.valueCell()
//            var content = cell.defaultContentConfiguration()
        
           print("Before getting image from network")
//            self.dispatchGroup.enter()
//            self.refCount += 1
//            print("after enter: \(self.refCount)")
//                self.viewModel.getImageFromNetwork(url: itemIdentifier.urls.thumb) { image in
//                    print("viewModel getImageFromNetwork succeed in \(Thread.current)")
//                    //                self.imageView.image = image
//
//                    print("Updating Image in, \(Thread.current)")
//                    content.image = UIImage(systemName: "star")
//
//                    //                content.image = image
//                    content.imageProperties.cornerRadius = 20
//                    content.imageProperties.maximumSize.height = 100
//                    print("Setting Image is done")
//                    self.refCount -= 1
//                    self.dispatchGroup.leave()
//                    print("after leave: \(self.refCount)")
//                }
//
//            self.dispatchGroup.notify(queue: .main) {
//                print("It's getting done?: \(self.refCount)")
//            }
            
            content.image = self.viewModel.imageLists[indexPath.item]
            
            print("Code after gettingImagefromNetwork")
            
            content.text = itemIdentifier.user.username
            content.secondaryText = itemIdentifier.description
        
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            content.secondaryTextProperties.font = .systemFont(ofSize: 12, weight: .medium)
            
            cell.contentConfiguration = content
            print("End of block")
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
        print("Cell creation is done!")
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
