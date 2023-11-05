//
//  SimpleCollectionViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/14.
//

import UIKit
import SnapKit

class SimpleCollectionViewController: UIViewController {
    
    //section 구분용 enum
    //여러 case 대응: CaseIterable
    enum Section: Int, CaseIterable {
        case first = 2000
        case second = 1
    }
    
    //중복된 data라도 인간 입장에서 고유함 의미 ~ index 기준
    //index 제외: unique하지 않음 --> 고유함 보장하기 위해 Hashable protocol 채택 필요
    
//    //UUID 활용 ~ instance 생성 때 알아서 생성 --> 구분 가능
//    private var list = [User(name: "Hue", age: 23),
//                        User(name: "Hue", age: 23),
////                        User(name: "Jack", age: 21),
//                        User(name: "Bran", age: 20),
//                        User(name: "Kokojong", age: 20)
//    ]
//    
//    private var list2 = [User(name: "Jack", age: 23),
//                        User(name: "Jack", age: 23),
//                        User(name: "Bran", age: 20),
//                        User(name: "Kokojong", age: 20)
//    ]
    
    
    //viewModel로 data 이전
    let viewModel = SimpleCollectionViewModel()
    
    
    let searchBar = UISearchBar()
    
    //instance 생성 시에 layout 설정 필요
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    //CellRegistration 등록용
    //어떤 type의 cell 활용, 어떤 type의 data 활용 정의
    //ListCell: iOS 14 이상, system cell 설정
//    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    //Diffable DataSource --> Configure 메서드 안에서만 활용
    //Configure 메서드 안에서 선언하며 초기화하기
    
    
    //DiffableDataSource: class --> instance 생성 필요
    //Section type, Cell에 보여줄 data type
//    var diffableDataSource: UICollectionViewDiffableDataSource<Int, User>!
    
    //section type 고유성 구분만 되면 okay --> Int 대신 enum type으로 겹치지만 않도록 하기
//    var diffableDataSource: UICollectionViewDiffableDataSource<Section, User>!
    
    //enum 만들지 않고 string으로 대응하기 (구분만 되면 okay)
    var diffableDataSource: UICollectionViewDiffableDataSource<String, User>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBar에 넣기
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        view.addSubview(collectionView)
        //didSelectItemAt: delegate 설정
        collectionView.delegate = self
//        collectionView.dataSource = self
                
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
            
        //method로 호출하기
        //snapshot보다 먼저 호출 필요
        configureDataSource()
            
        //data 업데이트 시 작업할 내용
        viewModel.list.bind { users in
            //snapshot 갱신하기
            //메서드로 분리
            self.updateSnapshot()
        }
        
        viewModel.append()
        
    }
    
    private func updateSnapshot() {
        //numberOfItemsInSection 구현
        
        //data 보내줌: snapshot 역할
        //view에 보여지게 할 고유한 값
        //DiffableDataSource가 가진 타입과 동일하게 타입을 가지고 있어야 함
//        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()

        //data가 고유하기만 하면 됨: Int 대신 enum, 극단적으로는 Bool도 가능
//        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()

        //String 쓰는 snapshot으로 하기
        var snapshot = NSDiffableDataSourceSnapshot<String, User>()
        
        //개별 section, 개별 item
        //고유한 section 구성만 하면 됨 (값이 겹치지만 않으면 okay)
        //등록한 순서대로 section 구성 ~ 각 section에 등록할 data만 연결해주면 끝 (따로 indexPath로 위치 적용할 이유 없음)
        
        //각 section을 열거형으로 나타내기 (Int literal 관리 어려움)
        //CaseIterable 활용 --> 모든 case 대응하기
//        snapshot.appendSections([Section.first.rawValue, Section.second.rawValue])
        
        //allCases: [first, second]만 가짐
        //고유하기만 하면 됨: snapshot의 data type을 Section으로 개선
//        snapshot.appendSections(Section.allCases)
        
        //String 활용 시
        snapshot.appendSections(["고래밥", "Jack"])


        //item과 section 연결하는 parameter: toSection

        //여러 section 동일 data 등록: 에러 발생 by uuid (고유성 문제)
        //다른 data 등록해야 함
//        snapshot.appendItems(list, toSection: Section.first)      //list.count 역할
//        snapshot.appendItems(list2, toSection: Section.second)

        
        //String 활용 시
        
        //viewModel로 data 이동: list data update된 값 parameter로 받아와서 활용
        snapshot.appendItems(viewModel.list.value, toSection: "고래밥")      //list.count 역할
//        snapshot.appendItems(viewModel.list.value, toSection: "고래밥")      //list.count 역할
        snapshot.appendItems(viewModel.list2, toSection: "Jack")
        
        //snapshot 반영, view에 적용하기
        diffableDataSource.apply(snapshot)
    }
    
    
    private func configureDataSource() {
        //UICollectionView.CellRegistration
        //iOS 14 이상
        //method 대신 Generic 활용: dequeueConfiguredReusableCell 메서드에서 cell이 생성될 때마다 closure 호출
        //cell UI 구성 및 data 처리 정의
        
        //Diffable DataSource 활용: configre 메서드 안에서만 활용
        //여기서 타입 명시하기
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
            //cell: UI 구성
            //itemIdentifier: cell당 보여줄 data
            
            //미리 design되어 있는 system cell 가지고 와서 활용 (list cell 활용)
            var content = UIListContentConfiguration.valueCell()
//            var content = UIListContentConfiguration.subtitleCell()
//            var content = UIListContentConfiguration.sidebarCell()
            
            //내부 property에 data 할당
            content.text = itemIdentifier.name
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            
            //UI 설정: Properties 접근
            content.textProperties.alignment = .center
            content.textProperties.color = .orange
            content.secondaryTextProperties.color = .yellow
            content.imageProperties.tintColor = .green
            
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            
            cell.contentConfiguration = content
            
            
            //background 설정 (cell 전체적인 background 설정)
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .purple
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 5
            backgroundConfig.strokeColor = .blue
            
            cell.backgroundConfiguration = backgroundConfig
            
        })
        
        //Diffable DataSource 초기화
        //cellProvider: CellRegistration과 비슷한 형태
        //CellForItemAt 대체 역할
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            //내부 작성 collectionView: DataSource의 cellForItemAt에서 cell 재사용 위해 registration 하는 과정
            //item: list의 indexPath 활용해서 직접 가져오기보다 itemIdentifier 활용하기
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    
    
    private func updateUI() {
        //UI 변경 확인 코드
        //viewModel로 data 옮긴 경우
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //data 추가
            self.viewModel.append()
//            self.list.insert(User(name: "뽀로로", age: 2), at: 2)

            
            //data 변경: collectionView update
            //apply(): 시스템이 알아서 바꿔야 하는 지점만 update
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            //data 삭제
            self.viewModel.remove()
//            self.list.remove(at: 3)

            self.updateSnapshot()
        }
    }
    
    
    
    //FlowLayout 쓰지 않는 방향
    //system style 기반 구성 --> List Configuration 활용
    
    //instance 생성보다 먼저 이뤄저야 하므로, static 설정
    //or collectionView를 lazy로 선언
    static private func createLayout() -> UICollectionViewLayout {
        
        //전체 collectionView 설정
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)      //apperance ~ sidebar: iPad 활용 다수
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemPink
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
//        collectionView.collectionViewLayout = layout
        return layout
    }
    
}

//MARK: - Extension for CollectionView Delegate, DataSource

//extension SimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        //재사용 cell 만드는 다른 방법
//        //CellRegistration: cell UI 설정 및 data 구성 처리 ~ 등록만 처리
//        //item: data 들어갈 자리
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
//        return cell
//    }
//
//}

//Delegate: cell 상호작용 및 action 관련
//didSelect 관련...

//CollectionViewDataSource: Data 표현, display 관련
//numberOfItemsInSection, cellForItemAt

//Diffable DataSource: CollectionViewDataSource 개선

//class, DataSource protocol 채택


//MARK: - Extension for CollectionView Delegate

extension SimpleCollectionViewController: UICollectionViewDelegate {
    
    //해당 cell 선택 시, 데이터 삭제하기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //해당 cell에 해당하는 data를 다루기 (값 전달 등등...): indexPath를 주로 활용
        let user = viewModel.list.value[indexPath.item]
        dump(user)
        
        //DiffableDataSource: indexPath 대신 model 기반으로 가져오기
        guard let item = diffableDataSource.itemIdentifier(for: indexPath) else {
            print("해당 data 존재하지 않음 예외처리")
            return
        }
        dump(item)
        
        
        //데이터 삭제도 viewModel에게 맡겨야 함
        viewModel.removeUser(indexPath: indexPath)
        
        //data가 변경되기에 다시 snapshot 찍어서 apply할 것
    }
    
    
    
}


//MARK: - Extension for SearchBar Delegate

extension SimpleCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //viewModel의 list에 data 추가하기
        viewModel.insertUser(name: searchBar.text!)
        
        //새로운 data 추가: snapshot 다시 찍어서 apply할 것
    }
    
}
