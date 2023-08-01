//
//  ViewController.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/01.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookAuthorLabel: UILabel!
    @IBOutlet var bookCoverImageView: UIImageView!
    
    @IBOutlet var bookRateLabel: UILabel!
    @IBOutlet var bookLikeCountLabel: UILabel!
    
    @IBOutlet var bookInfoLabel: UILabel!
    @IBOutlet var bookMemoTextView: UITextView!
    
    var book: Book?
    
    static let identifier = "DetailViewController"
    
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupDataFromCell()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //돌아가기: textView의 내용 저장하기
        UserDefaults.standard.set(bookMemoTextView.text, forKey: book!.title)
    }
        
    func configUI() {
        configView()
        configLabels()
        configTextView()
    }
    
    func configView() {
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func configLabels() {
        bookTitleLabel.textColor = .white
        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        bookAuthorLabel.textColor = .lightGray
        bookAuthorLabel.font = .systemFont(ofSize: 16)
        
        bookRateLabel.textColor = .darkGray
        bookRateLabel.font = .systemFont(ofSize: 14)
        
        bookLikeCountLabel.textColor = .lightGray
        bookLikeCountLabel.font = .systemFont(ofSize: 12)
        
        bookInfoLabel.numberOfLines = 0
    }
    
    func configTextView() {
        bookMemoTextView.textColor = .black
        bookMemoTextView.textAlignment = .left
        //메모 불러오기
        if let savedMemo = UserDefaults.standard.string(forKey: book!.title) {
            bookMemoTextView.text = savedMemo
        }
    }
    
    
    //MARK: - API

    //textView 이외 부분 탭: 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

    //didSet으로 미리 못하는 이유: 받은 data를 할당받을 Interface Builder component들이 아직 메모리로 안올라옴.
    func setupDataFromCell() {

        guard let book = book else {
            print("No book data from collectionView")
            return
        }
                
        bookTitleLabel.text = book.title
        bookRateLabel.text = "평점★\(book.rate)"
        bookInfoLabel.text = book.overview
        bookCoverImageView.image = BookCoverTitle(rawValue: book.title)?.coverImage
        
        //like count 대신 날짜 넣기
        bookLikeCountLabel.text = book.releaseDate
        
        //author 대신 runtime 넣기
        bookAuthorLabel.text = "\(book.runtime)"
    }
    
}

