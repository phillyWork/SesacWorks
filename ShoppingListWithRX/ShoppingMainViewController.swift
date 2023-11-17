//
//  ViewController.swift
//  ShoppingListWithRX
//
//  Created by Heedon on 2023/11/05.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ShoppingMainViewController: UIViewController {

    //MARK: - Properties
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "무엇을 구매하실 건가요?"
        return searchBar
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .red
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.backgroundColor = .orange
        return view
    }()
    
    var diffableDataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    let disposeBag = DisposeBag()
    
    let viewModel = ShoppingMainViewModel()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        setConstraints()
        
        setDiffableDataSource()
        
        bind()
    }
    
    func configureViews() {
        title = "쇼핑"
        
        view.addSubview(searchBar)
        view.addSubview(addButton)
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.2)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchBar.snp.trailing).inset(10)
            make.centerY.equalTo(searchBar)
            make.height.equalTo(searchBar.snp.height).multipliedBy(0.5)
            make.width.equalTo(addButton.snp.height).multipliedBy(1.3)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Compositional Layout & DiffableDataSource

    func setCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.interItemSpacing = .fixed(5)
        
        let section = NSCollectionLayoutSection(group: group)
        let edgeInsets: CGFloat = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: edgeInsets, leading: edgeInsets, bottom: edgeInsets, trailing: edgeInsets)
        section.interGroupSpacing = 5
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    
    func setDiffableDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<ShoppingListCell, String> { cell, indexPath, itemIdentifier in
            cell.todoLabel.text = itemIdentifier
            
            //add action in rx style
            cell.checkButton.rx.tap
                .subscribe(with: self) { owner, _ in
                    cell.toggleCheck()
                }
                .disposed(by: cell.disposeBag)
                
            cell.starButton.rx.tap
                .subscribe(with: self) { owner, _ in
                    cell.toggleStar()
                }
                .disposed(by: cell.disposeBag)
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    func updateSnapshot(_ data: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        diffableDataSource.apply(snapshot)
    }
    
    //MARK: - Rx

    func bind() {
        
        viewModel.items.subscribe(with: self) { owner, items in
            self.updateSnapshot(items)
        }
        .disposed(by: disposeBag)
        
        //실시간 검색
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, text in
                print("search text: ", text)
                let result = text == "" ? owner.viewModel.shoppingList : owner.viewModel.shoppingList.filter { $0.contains(text) }
                owner.viewModel.items.accept(result)
            }
            .disposed(by: disposeBag)
        
        //추가 버튼 탭 --> 새로운 입력값 data에 저장, tableView에 나타내기
        addButton.rx.tap
            .withLatestFrom(searchBar.rx.text.orEmpty) { void, text in
                return text
            }
            .subscribe(with: self) { owner, text in
                owner.viewModel.shoppingList.insert(text, at: 0)
                owner.viewModel.items.accept(owner.viewModel.shoppingList)
                owner.searchBar.text = nil
            }
            .disposed(by: disposeBag)
        
//        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(String.self))
//            .map { "Title: indexPath \($0), data \($1)" }
//            .subscribe(with: self, onNext: { owner, text in
//                let sampleVC = SamplePushViewController()
//                sampleVC.selectedCellDataFromMainVC = text
//                owner.navigationController?.pushViewController(sampleVC, animated: true)
//            })
//            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { "indexPath: \($0)" }
            .subscribe(with: self, onNext: { owner, text in
                let sampleVC = SamplePushViewController()
                sampleVC.selectedCellDataFromMainVC = text
                owner.navigationController?.pushViewController(sampleVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        
    }
    
}
