//
//  ViewController.swift
//  RxSwiftMovieAPI
//
//  Created by Heedon on 2023/11/06.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        return bar
    }()
    
    lazy private var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .orange
        view.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return view
    }()
    
    lazy private var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return view
    }()
    
    let vm = ViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        setConstraints()
        
        bind()
    }
    
    private func configureViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: 80)
        return layout
    }
    
    private func bind() {
        
        vm.placeholderForSearchBar
            .bind(to: searchBar.rx.text)
            .disposed(by: disposeBag)
        
        vm.dataForTable
            .bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) { row, element, cell in
                cell.titleLabel.text = element.movieNm
                cell.dateLabel.text = element.openDt
            }
            .disposed(by: disposeBag)
        
        vm.dataForCollection
            .bind(to: collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.identifier, cellType: MovieCollectionViewCell.self)) { item, element, cell in
                print("cell title: ", element.movieNm)
                cell.titleLabel.text = element.movieNm
            }
            .disposed(by: disposeBag)
        
        //searchBar의 text로 검색: network API call
        searchBar.rx.searchButtonClicked
            //UIControl action & String --> return String
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(searchBar.rx.text.orEmpty) { _, query in
                return query
            }
            .map { text -> String in
                guard let intText = Int(text) else { return "20231106" }
                return String(intText)
            }
            //일정 타이밍 지나서 수행
            .flatMap({ Network.fetchDataFromMovieAPI(date: $0) })
            .subscribe(with: self) { owner, data in
                let resultData = data.boxOfficeResult.dailyBoxOfficeList
                //성공시, subject에 전달
                owner.vm.dataForTable.onNext(resultData)
            } onError: { owner, error in
                if let networkError = error as? NetworkError {
                    switch networkError {
                    case .invalidURL:
                        print("Invalid URL")
                    case .notSuccessfulStatusCode:
                        print("Status Code is not successful")
                    case .notDecodable:
                        print("Data cannot be retreieved")
                    case .unknown:
                        print("Unknown Error occurred")
                    }
                }
            }
            .disposed(by: disposeBag)
    
        
        //tableView cell tap --> 해당 cell의 data를 collectionView의 data에 추가
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(DailyBoxOfficeList.self))
            .map { $0.1 }
            .subscribe(with: self) { owner, element in
                //기존 데이터 접근
                print("It's about to add")
                var data = owner.vm.dataForCollection.value
                data.append(element)
                owner.vm.dataForCollection.accept(data)
            }
            .disposed(by: disposeBag)
    }
    

}
