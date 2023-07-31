//
//  MovieCollectionViewController.swift
//  MovieCollectionViewAssignment
//
//  Created by Heedon on 2023/07/31.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController {

    //MARK: - Properties
    
    let dataManager = DataManager.shared
    
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
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
        return dataManager.getTotalMovie().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
    
        // Configure the cell
        let movie = dataManager.getTotalMovie()[indexPath.row]
        
        cell.configCell(movie: movie)
        
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        detailVC.title = dataManager.getTotalMovie()[indexPath.row].title
        //해당 cell의 backgroundColor 넘기기
        detailVC.view.backgroundColor = collectionView.cellForItem(at: indexPath)?.backgroundColor
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    @IBAction func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = storyboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
       
        let navVC = UINavigationController(rootViewController: searchVC)
        
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
    
  
}
