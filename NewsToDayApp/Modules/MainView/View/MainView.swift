//
//  MainView.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func getData() -> [ListSectionModel]
    func tappedFavoriteButton()
    func tappedSeeAllButton()
}

class MainView: CustomView {
    
    weak var delegate: MainViewDelegate?
    
    var collectionViewDelegate: UICollectionViewDelegate? {
            get {
                return self.collectionView.delegate
            }
            set {
                self.collectionView.delegate = newValue
            }
        }
    
     var searchBarDelegate: UISearchBarDelegate?{
        get {
            return self.searchBar.delegate
        }
        set {
            self.searchBar.delegate = newValue
        }
    }
    
    private let searchBar = SearchBarView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func setViews() {
        self.backgroundColor = .white
        configureCollectionView()
        [
            collectionView,
            searchBar
        ].forEach { addSubview($0) }
    }
    
    private func configureCollectionView(){
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.resuseID)
        collectionView.register(ArticleCouruselCell.self, forCellWithReuseIdentifier: ArticleCouruselCell.resuseID)
        collectionView.register(RecomendedCell.self, forCellWithReuseIdentifier: RecomendedCell.resuseID)
        collectionView.register(HeaderRecomendedView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderRecomendedView.resuseID)
    }
    
    override func layoutViews() {
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
            make.height.equalTo(56)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-5)
        }
    }
}

//MARK: - Create CollectionViewLayput
private extension MainView{
    private func createLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let data = delegate?.getData()
            let section = data?[sectionIndex]
            //mockData[sectionIndex]
            switch section{
            case .categories(_):
               return  createCategoriesSectionLayout()
            case .corusel(_):
               return createCoruselArticleSectionLayout()
            case .recomendations(_):
                return createRecomendedArticleSectionLayout()
            case .none:
                return nil
            }
        }
    }
    
    private func createCategoriesSectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .estimated(100), height: .estimated(32), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .continuous, groupSpacing: 16, leading: 16, trailing: 16, top: 8, bottom: 8, supplementary: nil)
        return section
    }
    
    private func createCoruselArticleSectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(0.8), height: .estimated(256), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .groupPaging, groupSpacing: 16, leading: 16, trailing: 16, top: 8, bottom: 32, supplementary: nil)
        return section
    }

    private func createRecomendedArticleSectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .estimated(96), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .none, groupSpacing: 16, leading: 16, trailing: 16, top: 16, bottom: 8, supplementary: [createHeader()])
        return section
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

//MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //mockData.count
        delegate?.getData().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = delegate?.getData()
        return data?[section].countData ?? 0
        //mockData[section].countData
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //mockData[indexPath.section]
        let data = delegate?.getData()
        let sections = data?[indexPath.section]
        switch sections{
        case .categories(let categories):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.resuseID, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
            cell.configCell(categoryLabelText: categories[indexPath.row].articleCategory)
            return cell
        case .corusel(let corusel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCouruselCell.resuseID, for: indexPath) as? ArticleCouruselCell else { return UICollectionViewCell() }
            let data = corusel[indexPath.row]
            cell.configCell(categoryLabelText: data.articleCategory, articleNameText: data.articleName, image: UIImage(named: data.image ?? "DefaultImage"))
            cell.delegate = self
            return cell
        case .recomendations(let recomendations):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendedCell.resuseID, for: indexPath) as? RecomendedCell else { return UICollectionViewCell() }
            let data = recomendations[indexPath.row]
            cell.configCell(categoryLabelText: data.articleCategory, articleNameText: data.articleName, image: UIImage(named: data.image ?? "DefaultImage"))
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderRecomendedView.resuseID, for: indexPath) as? HeaderRecomendedView else { return UICollectionReusableView()}
            let data = delegate?.getData()
            header.configureHeader(sectionTitle: data?[indexPath.section].title ?? "")
            header.delegate = self
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
//MARK: - FavoriteButton
extension MainView: ArticleCouruselCellDelegate {
    func tappedFavoriteButton() {
        delegate?.tappedFavoriteButton()
    }
}

//MARK: - HeaderButton SeeAll
extension MainView: HeaderRecomendedViewDelegate {
    func tappedSeeAllButton() {
        delegate?.tappedSeeAllButton()
    }
}

