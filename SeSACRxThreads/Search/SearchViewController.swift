//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

//화면 전환 test 목적
class SampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "\(Int.random(in: 1...100))"
    }
}

class SearchViewController: UIViewController {
     
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 80
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
    
    //더미 data 보여주기 목적
//    var items = BehaviorSubject(value: Array(100...150).map { "안녕하세요 \($0)"})
    
    //관리하는 data
    var data = ["A", "B", "C", "D", "AB", "E", "ABC"]
    
    //data 전달받을 것: data 생성 이후 받아야 함
    lazy var items = BehaviorSubject(value: data)
        
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
        setSearchController()
    }
     
    func bind() {
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element
                cell.appIconImageView.backgroundColor = .green
                
                //cell에서 구성해도 okay --> cell에서 화면전환 처리 액션 다시 VC로 넘겨줘야 (delegate, Notification, closure, ...)
                
                //VC에서 처리
                //버튼 누르는 tap 액션 자체는 데이터를 전달하지 않음
                cell.downloadButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        owner.navigationController?.pushViewController(SampleViewController(), animated: true)
                    }
                    //cell resource 정리: cell의 disposeBag
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        
        //didSelect in RxSwift
        //indexPath
        tableView.rx.itemSelected
            .subscribe(with: self) { owner, indexPath in
                print(indexPath)
            }
            .disposed(by: disposeBag)
        
        //data
        tableView.rx.modelSelected(String.self)
            .subscribe(with: self) { owner, data in
                print(data)
            }
            .disposed(by: disposeBag)
        
        //원래의 didSelect처럼 indexPath와 data 동시 활용하려함
        //zip: Observable 2개를 동시에 처리하기
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
            //String으로 변화
            .map { "Tap Result: \($0) \($1)" }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        
        //searchBar searchButtonClicked in Rx
        searchBar.rx.searchButtonClicked
        //2가지 Observable 결합
        //searchButton tap action에 새로운 Observable 결합
        //void: tap action의 return값
        //text: optional binding 처리한 searchbar text return값
            .withLatestFrom(searchBar.rx.text.orEmpty) { void, text in
                return text
            }
            //해당 text data 배열에 추가하기
            .subscribe(with: self) { owner, text in
                owner.data.insert(text, at: 0)
                //새롭게 update된 data를 다시 items에 전달
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        
        
        //실시간 검색 구현
        searchBar.rx.text.orEmpty
            //1초 뒤 실행하려는 동작 수행
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            //동일한 값 무시
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                let result = value == "" ? owner.data : owner.data.filter { $0.contains(value) }
                //검색 결과 items에 update하기
                owner.items.onNext(result)
            }
            .disposed(by: disposeBag)
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
