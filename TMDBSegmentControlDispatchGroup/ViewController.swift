//
//  ViewController.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupSegment()
        setupSearchBar()
        
        configCollectionView()
        configCollectionViewLayout()
        
        setupData()
    }

    func setupData() {

        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        dataManager.setupMovieList(type: .movie, movieId: dataManager.getMovieId(), pageNum: dataManager.getPageNum()) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataManager.setupVideoList(type: .video, movieId: dataManager.getMovieId()) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All async tasks are done!")
            self.collectionView.reloadData()
        }
    }
    
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
}

//MARK: - CollectionView Delegate, DataSource, Prefetching

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0: return dataManager.getMovieList().count
        case 1: return dataManager.getVideoList().count
        default: return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            cell.movie = dataManager.getMovieList()[indexPath.item]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else {
                return UICollectionViewCell()
            }
            cell.video = dataManager.getVideoList()[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //only for video
        if segmentControl.selectedSegmentIndex == 1 {
            
            let video = dataManager.getVideoList()[indexPath.item]
            
            guard let url = URL(string: URL.makeEndPointYoutubeURL(video.key)) else { return }

            //present safari web view with youtube url
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        //TMDB: page는 similar API만 요구
        if segmentControl.selectedSegmentIndex == 0 {
            for indexPath in indexPaths {
                //마지막 scroll하는 item의 index와 보유한 item 개수 - 1과 동일
                if dataManager.getMovieList().count - 1 == indexPath.item {
                    //새로운 page의 data 가져오기
                    dataManager.addPageNum()
                    dataManager.setupMovieList(type: .movie, movieId: dataManager.getMovieId(), pageNum: dataManager.getPageNum()) {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
}


//MARK: - CollectionViewConfigProtocol

extension ViewController: CollectionViewConfigProtocol {
    
    func configCollectionView() {
        collectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(UINib(nibName: VideoCell.identifier, bundle: nil), forCellWithReuseIdentifier: VideoCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .vertical
        
        let spacing: CGFloat = 8
        
        let width = UIScreen.main.bounds.width - spacing * 2
        
        flowLayout.itemSize = CGSize(width: width, height: width * 0.55)
        flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = flowLayout
    }
    
}

//MARK: - SearchBar Delegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        guard searchBar.searchTextField.hasText, let newMovieId = searchBar.text, checkNumber(text: newMovieId) else {
            print("Not matching movieID format")
            return
        }
        
        let newId = Int(newMovieId)!
        
        dataManager.resetData()
        dataManager.updateMovieID(id: newId)
        
        //dataManager에게 api call하기
        setupData()
    }
    
    func checkNumber(text: String) -> Bool {
        return Int(text) != nil ? true: false
    }
        
}

//MARK: - SetupUIProtocol

extension ViewController: SetupUIProtocol {
    
    func setupSegment() {
        segmentControl.selectedSegmentIndex = 0
        segmentControl.setTitle("비슷한 영화들", forSegmentAt: 0)
        segmentControl.setTitle("video", forSegmentAt: 1)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "영화 id를 입력해주세요"
        searchBar.searchTextField.textColor = .black
    }
}
