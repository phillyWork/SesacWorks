//
//  BookCollectionViewController.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/01.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookCollectionViewController: UICollectionViewController {

    //MARK: - Properties
    
    let dataManager = DataManager.shared
    
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        configNavBar()
        configCollectionView()
    }
    
    func configNavBar() {
        title = "고래밥님의 책장"
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func configCollectionView() {

        let layout = UICollectionViewFlowLayout()

        let deviceWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 15
        
        //2개 양쪽 동일 사이즈
        let deviceSize = (deviceWidth - spacing * 3) / 2
        
        layout.itemSize = CGSize(width: deviceSize, height: deviceSize)
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    

    //MARK: - UICollectionViewDataSource
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.getTotalBooks().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
    
        // Configure the cell
        let book = dataManager.getTotalBooks()[indexPath.row]
        
//        cell.configCell(book: book)
        
        //data 직접 전달, cell didSet으로 감지, configCell 메서드 수행
        cell.book = book
        
        //cell 내부의 버튼: interface action 연결 못함
        //cell은 반복 복사 --> 단순 연결: 모든 cell 영향 줌
        //tag로 구분 ~ tag 할당: action 함수 연결시 구분하기
        cell.likeButton.tag = indexPath.row
        
        //like button 누를 시, image 변화
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        //data 넘기기        
        detailVC.book = dataManager.getTotalBooks()[indexPath.row]
        
//        detailVC.title = dataManager.getTotalBooks()[indexPath.row].title
        
        //해당 cell의 backgroundColor 넘기기
        detailVC.view.backgroundColor = collectionView.cellForItem(at: indexPath)?.backgroundColor
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: - Handlers
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        //sender.tag를 indexPath.row 값으로 할당받음
        let cellBook = dataManager.getTotalBooks()[sender.tag]
        dataManager.updateBookLike(updatedBook: cellBook)
        collectionView.reloadData()
    }
    
    
    @IBAction func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = storyboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
       
        let navVC = UINavigationController(rootViewController: searchVC)
        
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
    

}
