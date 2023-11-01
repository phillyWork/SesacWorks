//
//  PhotoCollectionViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import UIKit

class PhotoCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel = PhotoViewModel()
    
    //section type, cell type
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar

        //collectionView: CompositionalLayout 설정
        collectionView.collectionViewLayout = createLayout()
        
        configureDataSource()
        
        //data 변경: snapshot으로 갱신하기
        viewModel.list.bind { data in
            self.updateSnapshot(data: data)
        }
        
    }
    
    private func updateSnapshot(data: Photo) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(data.results!)     //viewModel.list.value.results도 가능
        dataSource.apply(snapshot)
    }
    
    
    private func configureDataSource() {
        
        //CellRegistration
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            //url 기반 이미지 가져오기
            //background thread에게 일 처리 --> image 결과 받아오기 전에 이미 contentConfiguration 설정 끝남
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    
                    //이미지 받아오고 설정 끝내기: main.async 내에 같이 설정
                    cell.contentConfiguration = content
                }
                
            }
            
        }
        
        //cellForItemAt 대체
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
    
    
    //storyboard로 instance 연결 --> static func 설정 필요 없음
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemPink
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    

}

//MARK: - Extension for SearchBar Delegate

extension PhotoCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //검색어 입력 --> 네트워크 통신 진행 --> data 변경 --> bind 호출
        viewModel.fetchPhoto(text: searchBar.text!)
    }
    
}
