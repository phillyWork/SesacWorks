//
//  CollectionCompositionalViewController.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/21.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionCompositionalViewController: UIViewController {
    
    //MARK: - Properties
    
    let list = Array(0...100)
    
    //string data 길이 따라 다르게 나타내기
    let stringList = ["이모티콘", "새싹", "추석", "아이스크림", "박카스", "타우린함량", "애플tv", "collectionViewCompositionalLayout"]
    
    //frame zero: 크기 설정하지 않음 --> layout으로 이후에 잡기
    //collectionViewLayout: cell 크기 설정
    
    //instance property에 instance method 결과값 활용: instance 생성 이후 사용 가능
    //해결: lazy var instance로 구성 (collectionView가 method 이후 생성되도록)
    //다른 해결: static method로 활용 (type method가 instance와 상관 없음, data 영역 위치 (VC deinit 되어도 앱이 꺼질 때까지 위치)
    
//    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionCompositionalLayout())
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionEstimatedCompTagLayout())
//    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureEstimatedPinterestLayout())
    
    

    //Diffable DataSource 활용
    //generic: section data type, cell data type
    
    //DiffableDataSource: class
    //상속받는 class를 따로 만들어서 Diffable이 처리하는 것으로 분리 가능
    var diffableDataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    
    //String data 활용하기
    var diffableStringDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    //unspalsh API 담기
    var diffablePhotoDataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        configureHierarchy()
        configureLayout()
        
        //Diffable 활용: CellReigstration으로 처리
//        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "cell")
        
//        configureDataSource()
//        configureStringDataSource()
        configurePhotoDataSource()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        
        //Diffable 활용: 필요없음
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureEstimatedPinterestLayout() -> UICollectionViewLayout {
        
        //디바이스 너비: 2개로 고정
        //유동적으로 달라지는 점: 높이
        
        //추정치: 적당한 size 제시해주긴 해야 함
        //layout 구성 따라서 추정치 변화해도 달라지지 않을 수도 있음
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
 
        //group 내 item 2개 반복적으로 고정
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        layout.configuration = configuration

        return layout
    }
    
    
    func configureCollectionEstimatedCompTagLayout() -> UICollectionViewLayout {
        //size 설정
        //상대적 ~속한 container 기준 ~ fractional
        //절대적: absolute
        //추정치: estimated (추정 평균값)
        
        //string 길이만큼 width 설정하기 --> 유동적 활용하기: item과 group 둘 다 estimated 설정 필수
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //cell height 두꺼움 ~ height 줄이기
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30))
 
        //item이 group에 가득 차도록 만들기: 고정된 개수로는 해결 못함
        //subitems 활용: 몇 개 반복될 지는 모름
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        //collectionView scroll: vertical --> 가로로 채울 만큼 채우고 밑으로 내리기
        
        
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 10
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        layout.configuration = configuration

        return layout
    }
    
    
    
    //compositionalLayout으로 구성하기: cell size가 유동적 / 수평 scroll 다 다르게 & section 별 다른 구성
    //layout에서 시작, 역으로 instance 하나씩 구성해나가는 과정
    func configureCollectionCompositionalLayout() -> UICollectionViewLayout {

        //layoutSize
        //item이 속한 container: group --> group width의 1/3을 차지 의미
        //height: group과 동일한 height 가지기 --> 1.0 비율 적용
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0))
        
        //layoutItem
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //layoutSize
        //absolute: 고정값 적용
        //fractionalWidth, 비율 1.0 --> 속한 container와의 비율 적용
        //group: section에 속하기에 1.0: 디바이스 너비와 동일해짐
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
 
        //layoutGroup
        //repeatingSubitem: 반복할 item
        //count: 반복 횟수
        
        //e.g.) AppStore 구성: group in vertical

//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        
        //horizaontal vs. vertical: group 내 item 배치
        //group size와 알맞게 들어가지 않으면 화면에 제대로 나타나지 않음
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        
        //group count 맞게 item size 다시 계산 (WWDC2019) --> deprecated
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: <#T##NSCollectionLayoutSize#>, subitem: <#T##NSCollectionLayoutItem#>, count: <#T##Int#>)
        
        //group 내 간격 생성
        group.interItemSpacing = .fixed(15)
        
//        group.interItemSpacing = .flexible(10)
        
        
        //Section을 instance로 보유
        let section = NSCollectionLayoutSection(group: group)
        
        //group 간 간격 생성
        section.interGroupSpacing = 50
        
        //item 어디서부터 둘 것인지 설정: inset 구성
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        
        //CollectionViewLayout protocol 채택
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        //layout 설정 by configuration
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        layout.configuration = configuration

        
        //여러 section 구성 가능
        //코드 추가 필요

        
        return layout
    }

    //간단한 UI 구성 (단순 n * n 구성)
    func configureCollectionFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }

    
    
    
    func configurePhotoDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SearchCell, PhotoResult> { cell, indexPath, itemIdentifier in
            //cell 내부의 component 설정
            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.urls.thumb)!)
            cell.label.text = "\(itemIdentifier.created_at)"
        }
        
        diffablePhotoDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            //재사용: dataSource 기반 설정
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
    }
    
    //Photo type 받아서 [PhotoResult] 활용하기
    func configureSnapshot(_ item: Photo) {
        
        //snapshot 준비: dataSource와 동일 타입
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])        //section을 indexPath로 관리하지 않음, 설정 type대로 관리
        snapshot.appendItems(item.results)
        
        //snapshot 찍기
        diffablePhotoDataSource.apply(snapshot)
    }
    
    func configureStringDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SearchCell, String> { cell, indexPath, itemIdentifier in
            //cell 내부의 component 설정
            cell.imageView.backgroundColor = .orange
            cell.imageView.image = UIImage(systemName: "star")
            cell.label.text = "\(self.stringList[indexPath.item])"
        }
        
        diffableStringDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            //재사용: dataSource 기반 설정
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        //snapshot 준비: dataSource와 동일 타입
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])        //section을 indexPath로 관리하지 않음, 설정 type대로 관리
        snapshot.appendItems(stringList)
        
        //snapshot 찍기
        diffableStringDataSource.apply(snapshot)
        
    }
    
    func configureDataSource() {
        
        //cell 등록해서 SearchCell 활용할 것 설정
        //generic: cell type, data type 정의
        let cellRegistration = UICollectionView.CellRegistration<SearchCell, Int> { cell, indexPath, itemIdentifier in
            //cell 내부의 component 설정
            cell.imageView.backgroundColor = .orange
            cell.imageView.image = UIImage(systemName: "star")
            cell.label.text = "\(self.list[indexPath.item])번째"
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            //재사용: dataSource 기반 설정
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        //snapshot 준비: dataSource와 동일 타입
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])        //section을 indexPath로 관리하지 않음, 설정 type대로 관리
        snapshot.appendItems(list)
        
        //snapshot 찍기
        diffableDataSource.apply(snapshot)
        
    }
    
    
}


//MARK: - Extension for SearchBar Delegate
extension CollectionCompositionalViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        Network.shared.requestConvertible(type: Photo.self, api: .search(query: searchBar.text!)) { response in
            switch response {
            case .success(let success):
                
                //data 처리 & UI 갱신
                            
                //column count: 가로 기준 몇개의 cell 놓을 지
                //spacing: cell간 간격
                //contentWidth: device 가로 길이만큼 설정
                
                //ratio: 각 cell의 비율 알려주기
                let ratios = success.results.map { Ratio(ratio: $0.width / $0.height) }
                
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self.view.frame.width)
                
                //성공: 검색때마다 이미지 비율 달라짐
                //결과 바뀜 대응
//                self.collectionView.collectionViewLayout = self.configureEstimatedPinterestLayout()

                //빈칸 채울 pinterst layout으로
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                
                //먼저 snapshot 대응: 결과가 최상단으로 나타나지 않음
                self.configureSnapshot(success)

                dump(success)
                
            case .failure(let failure):
                print("실패 alert/toast 필요: ", failure.localizedDescription)
            }
        }
        
    }
    
}



//Diffable 활용: protocol 활용하지 않음
//내부 함수: 직접 만든 함수처럼 활용

//Diffable로 대체: 활용하지 않음

//extension CollectionCompositionalViewController {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
//        cell.label.text = "\(list[indexPath.item])번째"
//        return cell
//    }
//
//}



//MARK: - Extension for CollectionView Delegate, DataSource

//extension CollectionCompositionalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
//        cell.label.text = "\(list[indexPath.item])번째"
//        return cell
//    }
//
//}
