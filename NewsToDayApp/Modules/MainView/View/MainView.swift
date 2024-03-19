//
//  MainView.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func getSections() -> Int
}

class MainView: CustomView {
    
    weak var delegate: MainViewDelegate?
    
    private var mockData: [ListSectionModel]{
        let data1 = CategorySectionModel.getCategories()
        let data2 = CoruselSectionModel.getCourusel()
        let data3 = CoruselSectionModel.getCourusel()
        return   [.categories(data1), .corusel(data2), .recomendations(data3)]
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
        configSearchBar()
        addSubview(collectionView)
        addSubview(searchBar)
        
    }
    
    private func configSearchBar(){
        searchBar.delegate = self
    }
    
    private func configureCollectionView(){
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
        collectionView.delegate = self
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
        mockData.count
        //delegate?.getSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0: return mockData[section].countCategories
        case 1: return mockData[section].countCorusel
        case 2: return mockData[section].countRecomendations
        default:
            print("Default section")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch mockData[indexPath.section]{
        case .categories(let categories):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.resuseID, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
            cell.configCell(categoryLabelText: categories[indexPath.row].title)
            return cell
        case .corusel(let corusel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCouruselCell.resuseID, for: indexPath) as? ArticleCouruselCell else { return UICollectionViewCell() }
            let data = corusel[indexPath.row]
            cell.configCell(categoryLabelText: data.articleCategory, articleNameText: data.articleName, image: UIImage(named: data.image))
            return cell
        case .recomendations(let recomendations):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendedCell.resuseID, for: indexPath) as? RecomendedCell else { return UICollectionViewCell() }
            let data = recomendations[indexPath.row]
            cell.configCell(categoryLabelText: data.articleCategory, articleNameText: data.articleName, image: UIImage(named: data.image))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderRecomendedView.resuseID, for: indexPath) as? HeaderRecomendedView else { return UICollectionReusableView()}
            header.configureHeader(sectionTitle: mockData[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
//MARK: - UISearchBarDelegate
extension MainView: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        print(searchText)
        searchBar.resignFirstResponder()
    }
    
}
//MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate{
}

