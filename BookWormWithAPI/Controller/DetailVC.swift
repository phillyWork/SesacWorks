//
//  DetailVC.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    static let identifier = "DetailVC"
    
    let dataManager = DataManager.shared
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var memoTextView: UITextView!
    
    var book: Book?
    
    var realmBook: BookTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memoTextView.delegate = self
        
        configUI()
        
        configBookData()
    }
    
    
    func configBookData() {
        if let book = book {
            let url = URL(string: book.thumbnailURL)
            coverImageView.kf.setImage(with: url)
            
            titleLabel.text = book.title
            detailLabel.text = book.description
            descriptionLabel.text = book.contents
        } else {
            guard let realmBook = realmBook else { return }
            if let thumbnail = realmBook.thumbnailURL {
                let url = URL(string: thumbnail)
                coverImageView.kf.setImage(with: url)
            }
            
            titleLabel.text = realmBook.title
            detailLabel.text = realmBook.description
            descriptionLabel.text = realmBook.contents
            memoTextView.text = realmBook.memo
        }
    }
    
    @objc func editButtonTapped() {
        guard let realmBook = realmBook else { return }
        
        if let memo = memoTextView.text, !memo.isEmpty {
            //upsert
//            dataManager.updateRealmHistoryBooks(task: ["_id": realmBook._id,
//                                                       "title": realmBook.title,
//                                                       "author": realmBook.author,
//                                                       "contents": realmBook.contents,
//                                                       "date": realmBook.date,
//                                                       "isbn": realmBook.isbn,
//                                                       "thumbnailURL": realmBook.thumbnailURL,
//                                                       "price": realmBook.price,
//                                                       "like": realmBook.like,
//                                                       "memo": memo], type: .upsert)
            
            //partial
            dataManager.updateRealmHistoryBooks(attributes: ["_id": realmBook._id, "memo": memo], type: .partial)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteButtonTapped() {
        
        guard let task = realmBook else { return }
        
        //Document에서 삭제
        removeFromDocument(fileName: "philllyy_\(task._id).jpg")
        
        //realm에서 삭제
        dataManager.deleteRealmHistoryBooks(book: task)
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
//        if !textView.text.isEmpty {
//            UserDefaults.standard.set(textView.text, forKey: "memo")
//        }
    }
}


extension DetailVC {
    
    func configUI() {
    
        coverImageView.contentMode = .scaleToFill
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        lineView.backgroundColor = .black
        lineView.layer.borderColor = UIColor.black.cgColor
        lineView.layer.borderWidth = 1
        
        detailLabel.textColor = .black
        detailLabel.font = .systemFont(ofSize: 13)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 11)
        
//        memoTextView.text = UserDefaults.standard.string(forKey: "memo")
        memoTextView.text = nil
        if memoTextView.text.isEmpty {
            memoTextView.text = "메모를 입력해보세요"
            memoTextView.textColor = .darkGray
        } else {
            memoTextView.textColor = .black
        }
        
        setupTextViewToolBar()
        keyboardLayout()
       }
    
    func setupTextViewToolBar() {
        //setting toolbar on top of keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let deleteButton = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteButtonTapped))
        let editButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonTapped))
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        toolbar.setItems([deleteButton, flexibleSpace, editButton], animated: false)
        
        memoTextView.inputAccessoryView = toolbar
    }
    
    //keyboard layout guide
//    @available(iOS 15.0, *)
    func keyboardLayout() {
        memoTextView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -50).isActive = true
    }
    
}
