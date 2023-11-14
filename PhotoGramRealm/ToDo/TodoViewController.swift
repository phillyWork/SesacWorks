//
//  TodoViewController.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/08.
//

import UIKit
import RealmSwift
import SnapKit

class TodoViewController: BaseViewController {
    
    let tableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let realm = try! Realm()
    
    var list: Results<TodoTable>!
    var detailList: Results<DetailTodoTable>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //realm 위치 확인
        print(realm.configuration.fileURL)
        
        //DetailTodo table 독립적으로 활용도 가능
        
//        createTodo()
//        createDetailTodo()
        
        let data = TodoTable(title: "장보기", favorite: true)
        
        let detail1 = DetailTodoTable(detail: "양파", deadline: Date() )
        let detail2 = DetailTodoTable(detail: "사과", deadline: Date() )
        let detail3 = DetailTodoTable(detail: "고구마", deadline: Date() )
        
        //realm 통해 추가 아니므로 미리 작성해도 okay
        data.detail.append(detail1)
        data.detail.append(detail2)
        data.detail.append(detail3)
        
        
        // Memo 구성
        
        let data2 = TodoTable(title: "영화보기", favorite: false)
        
        let memo = MemoTable()
        memo.content = "주말에 영화보기"
        memo.date = Date()
        
        //realm 통해 추가하는 것 아니므로 미리 작성해도 okay
        data2.memo = memo
        
        try! realm.write {
            realm.add(data)
            realm.add(data2)
        }
        
        list = realm.objects(TodoTable.self)
        detailList = realm.objects(DetailTodoTable.self)
        
    }
    
    override func configure() {
        super.configure()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func createTodo() {
        //table에 데이터 추가
        for i in ["장보기", "영화보기", "리캡하기", "좋아요구현하기", "잠자기"] {
            let data = TodoTable(title: i, favorite: false)
            
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    
    func createDetailTodo() {
        //TodoTable에서 filter해서 "장보기"만 가져오기
        //title이 PK가 아니므로 그 중 첫번째 가져오기
        let main = realm.objects(TodoTable.self).where { $0.title == "장보기" }.first!
        
        //세부 항목 등록
        for i in 1...10 {
            let detailTodo = DetailTodoTable(detail: "장보기 세부 할일 \(i)", deadline: Date() )
            
            try! realm.write {
                //default.realm 내 직접적 table 구성
//                realm.add(detailTodo)

                //filter로 가져온 record에 detail property에 추가하기
                //detail property: DetailTodo 가짐
                
                main.detail.append(detailTodo)
            }
        }
    }
    
}

//MARK: - Extension for TableView Delegate, DataSource

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = "\(list[indexPath.row].title): \(list[indexPath.row].detail.count)개 \(list[indexPath.row].memo?.content ?? "")"
//        return cell

        //DetailTodo로 Todo까지 나타내기
        //first: 한개만 가져옴 (하나만 존재한다고 가정)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(detailList[indexPath.row].detail) in \(detailList[indexPath.row].mainTodo.first?.title ?? "")"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Todo table의 record 제거: column으로 존재하는 DetailTodo table도 지워야 함
        
        //Todo table record 먼저 제거: DeatilTodo table은 남아있음 (접근은 불가)
        //DetailTodo table 먼저 제거 후 Todo table 제거하기
        
//        let data = list[indexPath.row]
//
//        try! realm.write {
//            realm.delete(data.detail)
//            realm.delete(data)
//        }
        
        
        //Detail table 활용

//        let data = detailList[indexPath.row]
//
//        try! realm.write {
//            realm.delete(data)
//        }
//
//        tableView.reloadData()
        
    }
    
}
