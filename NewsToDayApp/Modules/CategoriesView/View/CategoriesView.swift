//
//  CategoriesView.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import Foundation
import UIKit
protocol CategoriesViewDelegate: AnyObject {
}


class CategoriesView: CustomView {
    weak var delegate: CategoriesViewDelegate?
    
    private let title = LabelsFactory.makeHeaderLabel()
    private let subTitle = LabelsFactory.makeTextLabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private let button = ButtonsFactory.makeButton()
    
    override func setViews(){
        self.backgroundColor = .white
        configureCollectionView()
        setUpViews()
        [
            title,
            subTitle,
            collectionView,
            button,
        ].forEach{ addSubview($0) }
        
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("CategoriesViewTitle", comment: "")
        subTitle.text = NSLocalizedString("CategoriesViewSubTitle", comment: "")
    }
    
    override func layoutViews() {
        
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.leading.equalToSuperview().offset(16)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(button.snp.top).offset(-8)
        }
        
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.height.equalTo(56)
        }
    }
    
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.resuseID)
    }
    
}

//MARK: - CategoriesVCDelegate
extension CategoriesView: CategoriesVCDelegate {
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setCollectionViewDelegate(vc: CategoriesViewController) {
        collectionView.delegate = vc
        
    }
    
    func setCollectionViewDataSource(vc: CategoriesViewController) {
        collectionView.dataSource = vc
    }
    
    
}
