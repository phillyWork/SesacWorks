//
//  AddViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift

class AddViewController: BaseViewController {
     
     let userImageView: PhotoImageView = {
         let view = PhotoImageView(frame: .zero)
         return view
     }()
     
     let titleTextField: WriteTextField = {
         let view = WriteTextField()
         view.placeholder = "제목을 입력해주세요"
         return view
     }()
     
     let dateTextField: WriteTextField = {
         let view = WriteTextField()
         view.placeholder = "날짜를 입력해주세요"
         return view
     }()
     
     let contentTextView: UITextView = {
         let view = UITextView()
         view.font = .systemFont(ofSize: 14)
         view.layer.borderWidth = Constants.Desgin.borderWidth
         view.layer.borderColor = Constants.BaseColor.border
         view.layer.cornerRadius = Constants.Desgin.cornerRadius
         return view
     }()
     
     lazy var searchImageButton: UIButton = {
         let view = UIButton()
         view.setImage(UIImage(systemName: "photo"), for: .normal)
         view.tintColor = Constants.BaseColor.text
         view.backgroundColor = Constants.BaseColor.point
         view.layer.cornerRadius = 25
         view.addTarget(self, action: #selector(searchImageButtonClicked), for: .touchUpInside)
         return view
     }()
    
    lazy var searchWebButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "web"), for: .normal)
        view.tintColor = Constants.BaseColor.text
        view.backgroundColor = Constants.BaseColor.point
        view.layer.cornerRadius = 25
        view.addTarget(self, action: #selector(searchWebButtonClicked), for: .touchUpInside)
        return view
    }()
      
    //image url 받을 변수
    var fullURL: String?
    
    
    //Repository instance
    let repository = PhotoDiaryTableRepository()
    
    
    override func viewDidLoad() {
        super.viewDidLoad() //안하는 경우 생기는 문제: Superclass의 viewDidLoad에서 설정한 값 적용되지 않음
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    //저장버튼: Realm에 저장하기
    @objc func saveButtonClicked() {
        
        //realm 어디에 있는지 탐색 필요 (경로 접근)
//        let realm = try! Realm()
        
        //data에 해당하는 class instance를 realm에 넣기
        //url type: Optional --> binding 없이 그대로 넣어도 okay
        let task = PhotoDiaryTable(diaryTitle: titleTextField.text!, diaryDate: Date(), diaryContents: contentTextView.text, diaryPhoto: fullURL)
        
        //realm transaction error
        //transaction 단위: 다른 code 진행 불가
        //try 내에서 처리해야 함
//        realm.add(task)
        
        //write: realm에 설정하기
//        try! realm.write {
//            realm.add(task)
//            print("Realm Add Succeed")
//        }
        
        
        //repository instance로 활용
        repository.createItem(task)
        
        
        //image url 대신 직접 image 파일 저장하기
        //repository에 같이 숨길 수도 있음
        if let image = userImageView.image {
            (fileName: "phlllly_\(task._id).jpg", image: image)
        }
        
       
        
        //realm에 저장될 image url 따로
        //documents에 직접 저장할 image 따로
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchImageButtonClicked() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func searchWebButtonClicked() {
        let vc = SearchViewController()
        vc.didSelectItemHandler = { [weak self] value in
            
            //url 저장
            self?.fullURL = value
            
            DispatchQueue.global().async {
                if let url = URL(string: value), let data = try? Data(contentsOf: url ) {
                    
                    DispatchQueue.main.async {
                        self?.userImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        present(vc, animated: true)
    }
    
    override func configure() {
        super.configure()
        
        [userImageView, titleTextField, dateTextField, contentTextView, searchImageButton, searchWebButton].forEach {
            view.addSubview($0)
        }

    }
    
    override func setConstraints() {
          
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(view.snp.width).multipliedBy(0.55)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(55)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(55)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(12)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
        
        searchImageButton.snp.makeConstraints { make in
            make.trailing.equalTo(userImageView.snp.trailing).offset(-12)
            make.bottom.equalTo(userImageView.snp.bottom).offset(-12)
            make.width.height.equalTo(50)
        }
        
        searchWebButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchImageButton.snp.leading).offset(-12)
            make.bottom.equalTo(userImageView.snp.bottom).offset(-12)
            make.width.height.equalTo(50)
        }
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            userImageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
