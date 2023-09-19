//
//  BeerViewController.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import UIKit
import SnapKit
import Kingfisher

final class BeerViewController: UIViewController {

    //MARK: - Properties
    
    let viewModel = BeerViewModel()
    
    lazy var multipleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Multiple", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        
        button.addTarget(self, action: #selector(multipleButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var singleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Single", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        
        button.addTarget(self, action: #selector(singleButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        
        button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return  view
    }()
    
    var diffableDataSource: UICollectionViewDiffableDataSource<Int, Beer>!
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
        
        bindData()
    }
    
    //MARK: - Handlers
    
    @objc func multipleButtonTapped() {
        viewModel.networkCall(api: .multiple(page: viewModel.page.value))
    }
    
    @objc func singleButtonTapped() {
        if let id = viewModel.id {
            viewModel.networkCall(api: .single(id: id))
        }
    }
    
    @objc func randomButtonTapped() {
        viewModel.networkCall(api: .random)
    }
    
    //MARK: - API
    
    private func bindData() {
        viewModel.beers.bind { beers in
            if let beers = beers {
                self.updateSnapshot(data: beers)
            }
        }
        
        viewModel.page.bind { newPage in
            self.viewModel.networkCall(api: .multiple(page: newPage))
        }
    }
    
    private func updateSnapshot(data: [Beer]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Beer>()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        diffableDataSource.apply(snapshot)
    }
    

    private func configDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Beer> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.secondaryText = itemIdentifier.description
            
            self.viewModel.getImage(url: itemIdentifier.image_url) { image in
                DispatchQueue.main.async {
                    content.image = image
                    cell.contentConfiguration = content
                }
            }
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    
    private func configViews() {
        
        view.addSubview(multipleButton)
        view.addSubview(singleButton)
        view.addSubview(randomButton)
        view.addSubview(collectionView)
        
        multipleButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        singleButton.snp.makeConstraints { make in
            make.top.equalTo(multipleButton.snp.top)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(multipleButton.snp.size)
        }
        
        randomButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.size.equalTo(multipleButton.snp.size)
        }
        
        collectionView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(multipleButton.snp.bottom).offset(15)
        }
    }

}
