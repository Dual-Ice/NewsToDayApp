//
//  MainView.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit
import SnapKit

class MainView: CustomView {
    
    private var mockData: [ListSectionModel]{
        let data1 = CategorySectionModel.getCategories()
        let data2 = CoruselSectionModel.getCourusel()
        let data3 = CoruselSectionModel.getCourusel()
        return   [.categories(data1), .corusel(data2), .recomendations(data3)]
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func setViews() {
        self.backgroundColor = .white
        configureCollectionView()
        
    }
    
    private func configureCollectionView(){
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.resuseID)
        collectionView.register(ArticleCouruselCell.self, forCellWithReuseIdentifier: ArticleCouruselCell.resuseID)
        collectionView.register(RecomendedCell.self, forCellWithReuseIdentifier: RecomendedCell.resuseID)
        collectionView.register(HeaderRecomendedView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderRecomendedView.resuseID)
    }
    
    override func layoutViews() {
        
    }
    
}

//MARK: - Create CollectionViewLayput
private extension MainView{
    private func createLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let section = mockData[sectionIndex]
            switch section{
            case .categories(_):
               return  createCategoriesSectionLayout()
            case .corusel(_):
               return createCoruselArticleSectionLayout()
            case .recomendations(_):
                return createRecomendedArticleSectionLayout()
            }
        }
    }
    
    private func createCategoriesSectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .estimated(80), height: .estimated(32), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .continuous, groupSpacing: 8, leading: 8, trailing: 8, supplementary: nil)
        return section
    }
    
    private func createCoruselArticleSectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.8), height: .fractionalHeight(0.3), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .groupPaging, groupSpacing: 8, leading: 8, trailing: 8, supplementary: nil)
        return section
    }

    private func createRecomendedArticleSectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .estimated(96), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .none, groupSpacing: 8, leading: 8, trailing: 8, supplementary: [createHeader()])
        return section
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

