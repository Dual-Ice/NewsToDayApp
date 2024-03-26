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
}

class MainView: CustomView {
    
    weak var delegate: MainViewDelegate?
    
    private let title = LabelsFactory.makeHeaderLabel()
    private let subTitle = LabelsFactory.makeTextLabel()
    private let searchBar = SearchBarView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func setViews() {
        self.backgroundColor = .white
        setUpViews()
        configureCollectionView()
        [
            title,
            subTitle,
            collectionView,
            searchBar
        ].forEach { addSubview($0) }
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("MainViewTitle", comment: "")
        subTitle.text = NSLocalizedString("MainViewSubTitle", comment: "")
    }
    
    private func configureCollectionView(){
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.resuseID)
        collectionView.register(ArticleCouruselCell.self, forCellWithReuseIdentifier: ArticleCouruselCell.resuseID)
        collectionView.register(RecomendedCell.self, forCellWithReuseIdentifier: RecomendedCell.resuseID)
        collectionView.register(HeaderRecomendedView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderRecomendedView.resuseID)
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
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(subTitle.snp.bottom).offset(32)
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

//MARK: - MainVCDelegate
extension MainView: MainVCDelegate{
    func reloadOneCell(indexItem: Int, isLiked: Bool) {
        let indexPath = IndexPath(item: indexItem, section: 1)
        DispatchQueue.main.async {
            if let cell = self.collectionView.cellForItem(at: indexPath) as? ArticleCouruselCell{
                cell.setImageForFavoriteButton(isLiked: isLiked)
            }
        }
    }
    
    func setCollectionViewDataSource(vc: MainViewController) {
        collectionView.dataSource = vc
    }
    
    func setSearchBarDelegate(vc: MainViewController) {
        searchBar.delegate = vc
    }
    
    func setCollectionViewDelegate(vc: MainViewController) {
        collectionView.delegate = vc
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func reloadCollectionView(section: Int) {
        DispatchQueue.main.async {
            let indexSet = IndexSet(integer: section)
            self.collectionView.reloadSections(indexSet)
        }
    }
}

