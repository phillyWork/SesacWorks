//
//  HomeViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
        return view
    }()
    
    //realm에서 불러온 data 담을 변수
    var tasks: Results<PhotoDiaryTable>!

    //Repository instance로 구성하기
    let repository = PhotoDiaryTableRepository()
    
    //realm 위치 접근 --> repository instance로 관리하기
//    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //schema version 확인하기
        repository.checkSchemaVersion()
        
        
        //realm에서 data 가지고 오기: read
        //Table 전체 가져오기 (Meta type 활용)
        //정렬 query 활용: title 기준, 내림차순
//        let tasks = realm.objects(PhotoDiaryTable.self).sorted(byKeyPath: "diaryTitle", ascending: false)
        
        //Repository 메서드로 처리
        //VC에서는 어떤 db로 처리하는지 알 필요 없음
        let tasks = repository.fetch()
        
        print(tasks)
                
        //data 담기
        self.tasks = tasks
        
    }
    
    //view가 새로 뜰때마다 realm 확인하기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        
        //바뀐 data: UI update
        //실시간으로 data 가져오지 않아도 view에 대한 갱신으로 realm에 추가된 data가 나타남
        //Results type: auto로 update해줌 (Realm type 특성)
        self.tableView.reloadData()
    }
    
    override func configure() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    
    @objc func backupButtonClicked() {
        navigationController?.pushViewController(BackupViewController(), animated: true)
    }
    
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func filterButtonClicked() {
        //특정 조건/특정 검색어만 가져오기
        //table 전체 접근 --> where 활용: 조건 해당하는 것만 가져오기 (realm 제공 기능)
                
        //1) title 기준
        //option: 대소문자 구별 없애기 (caseInsensitive)
        //contains --> swift 자체 contains와 다른 타입 활용 (Realm Query API)
//        let results = realm.objects(PhotoDiaryTable.self).where { $0.diaryTitle.contains("제목", options: .caseInsensitive) }
        
        //2) like (Bool) 기준
//        let results = realm.objects(PhotoDiaryTable.self).where { $0.diaryLike == true }
        
        //3) 사진 있는 데이터만 (nil 여부 판단)
        //isEmpty: realm에서 제공하지 않음 (공식 문서 확인 필요)
//        let results = realm.objects(PhotoDiaryTable.self).where { $0.diaryPhoto != nil }

        //Repository 메서드 활용
        let results = repository.fetchFilter()
        
        //가져온 data 새로 담고 tableView UI 갱신
        tasks = results
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        
        cell.titleLabel.text = data.diaryTitle
        cell.contentLabel.text = "컨텐츠 레이블 컨텐츠 레이블 컨텐츠 레이블 컨텐츠 레이블 컨텐츠 레이블"
        cell.dateLabel.text = "\(data.diaryDate)"
        
        
//        //realm: transaction 기반 --> global thread에서 사용 불가 (위험)
//        //db의 Data 그대로 가져와 활용: 나눠서 구하기
//        let value = URL(string: data.diaryPhoto ?? "")
//
//        //다른 문제?
//        //cell에서 서버 통신: 용량이 크면 load에 시간 걸림
//        //--> 해결: DB에서 data 받아올 때, 미리 UIImage로 변환해서 image로 가지고 있다가, cell에 image 전달해서 load 시간 줄이기
//
//        //또 다른 문제 발생?
//        //모든 image로 변환: 유저가 보지 않을 것도 다 바꿈 (재사용 메커니즘 활용도 떨어짐) + image 배열 따로 구성: 시간 오래 걸릴 수 있음
//
//        //이미지 url 존재: 보여주기
//        DispatchQueue.global().async {
////            if let urlString = data.diaryPhoto, let url = URL(string: urlString),
//            if let url = value, let photoData = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    cell.diaryImageView.image = UIImage(data: photoData)
//                }
//            }
//        }
        
        
        //아예 이미지로 활용하기 (네트워크 통신 없이도 load 빠르게 하기)
        //fileName: column으로 관리 ~ 가져다 활용
        //없다면 PK 등으로 구분...
        cell.diaryImageView.image = loadImageFromDocument(fileName: "phlllly_\(data._id).jpg")
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //해당 record 가져오기
        let data = tasks[indexPath.row]

//        //realm delete
//        //탭하면 삭제되도록 구현하기
//
//        //Documents 폴더의 파일도 삭제해야 하는지 확인 작업 필요
//        removeImageFromDocument(fileName: "phlllly_\(data._id).jpg")
//
//        //realm에서 record 삭제
//        //record 먼저 삭제 --> data도 삭제 (auto update하는 특성): PK를 얻어오지 못함
//        //연관된 data 먼저 삭제하고 realm의 record 삭제하기
//        try! realm.write {
//            realm.delete(data)
//        }
//
//        tableView.reloadData()
        
        
        
        //realm update 구현하기 with 해당 record 같이 전달
        let detailVC = DetailViewController()
        detailVC.record = data
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    
    //custom swipe
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //actions: UIContextualAction
        //swipe 할 때 나타나는 버튼의 action
        let like = UIContextualAction(style: .normal, title: "좋아요") { action, view, completionHandler in
            print("좋아요 선택")
        }
        like.backgroundColor = .systemOrange
        //data 따라 달라보이게 설정 가능
        like.image = tasks[indexPath.row].diaryLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        let sample = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("테스트 선택")
        }
        sample.backgroundColor = .systemMint
        sample.image = UIImage(systemName: "star.fill")
        
        //반환값: UISwipeActionsConfiguration
        //action들 포함하기
        return UISwipeActionsConfiguration(actions: [like, sample])
    }
    
    
}
