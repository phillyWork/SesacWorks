//
//  DetailViewController.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    //HomeVC에서 넘어온 record
    var record: PhotoDiaryTable?
    
//    let realm = try! Realm()
    
    let repository = PhotoDiaryTableRepository()
    
    let titleTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    let contentTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "내용을 입력해주세요"
        return view
    }()
    
    override func configure() {
        super.configure()
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
        
        //받아온 data 확인하기
        print(record?.diaryTitle)
        
        guard let data = record else { return }
        
        titleTextField.text = data.diaryTitle
        contentTextField.text = data.contents
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
    @objc func editButtonTapped() {
        print("Tapped")
        
        guard let record = record else { return }
        
        //새로운 data로 realm update하기
        //어떤 record를 어떻게 수정할지 ~ PK로 구분
        //value: [수정하고자 하는 attribute: 해당 record의 atttribute값]
        
        //upsert 방식
        //update하려는 attribute 외 나머지 column들은 초기값으로 되돌아감
        let data = PhotoDiaryTable(value: ["_id": record._id, "diaryTitle": titleTextField.text!, "diaryContents": contentTextField.text!])
        
        //좀 더 안전하게 활용하기 (try! 오류 ~ 앱 강제종료)
//        do {
//            try realm.write {
//                //단순 추가가 아니라 modified option으로 수정하는 것 알림
////                realm.add(data, update: .modified)
//
//                //부분 수정 방식
//                //기존 data는 유지
//                //특정 table에서 수정하고 싶은 data 전달 with modified
//                realm.create(PhotoDiaryTable.self, value: ["_id": record._id, "diaryTitle": titleTextField.text!, "diaryContents": contentTextField.text!], update: .modified)
//            }
//        } catch {
//            print(error)
//        }

//        try! realm.write {
//            realm.add(data, update: .modified)
//        }
        
        
        //repository instance 활용
        repository.updateItem(id: data._id, title: titleTextField.text!, contents: contentTextField.text!)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(60)
        }
        
    }
    

}



