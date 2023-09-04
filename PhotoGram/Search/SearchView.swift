//
//  SearchView.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = {
        let bar = UISearchBar()
        bar.placeholder = "검색어를 입력해주세요"
        return bar
    }()
    
    //SearchVC의 rootView 역할이므로 SearchView에서 등록
    //SearchVC는 view 등록 신경쓰지 않도록 하기
    lazy var errorCollectionView = {
        
        let collection = UICollectionView()
        
        //protocol로 identifier 구성, 여기서는 그냥 String literal로
        collection.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        //instance 생성 전 closure 내에서 함수 호출 불가
        //lazy var로 설정 가능 (초기화 늦추기)
        collection.collectionViewLayout = collectionViewFlowLayout()
        
        return collection
    }()
    
    //그래도 똑같이 nil 오류 발생
    //collectionView 초기화되는 방식: layout에 대한 default 설정 필요
    //Apple이 명시적으로 나타내주진 않음 (런타임 오류 발생)
    
    lazy var collectionView = {
        //flowLayout 설정 필요
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout())
        collection.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        return collection
    }()
        
    override func configViews() {
        super.configViews()
        
        addSubview(searchBar)
//        addSubview(errorCollectionView)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
//        errorCollectionView.snp.makeConstraints { make in
//            make.horizontalEdges.bottom.equalToSuperview()
//            make.top.equalTo(searchBar.snp.bottom)
//        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    
    //collectionFlowLayout 설정
    
    //SearchVC에서 SearchView의 해당 메서드 호출할 일 없음
    //해당 class 안에서만 활용하도록 접근 제약 두기
    private func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        //searchView가 VC에 load되어서 디바이스 기준으로 잡혀야 그 때 frame 접근 가능
        //collectionView 생성 시점: 아직 frame이 0
        
        //cell이 나타나지 않음
        //Negative or zero item sizes are not supported by flow layout. Make a symbolic breakpoint at UICollectionViewFlowLayoutAlertForInvalidItemSize to catch this in the debugger. Invalid size: {-10, -10}; collection view: (null)
//        let size = self.frame.width - 40
        
        //layout 이상한지 확인: 정적 크기 먼저 할당해보기
//        let size = 200
                
        //frame 대신 device 자체 크기 활용
        let size = UIScreen.main.bounds.width - 40
        
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
    
}
