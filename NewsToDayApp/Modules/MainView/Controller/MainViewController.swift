//
//  MainViewController.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol MainVCDelegate{
    func reloadCollectionView()
    func reloadCollectionView(section: Int)
    func changeFavoriteCelButtonBackGround(indexItem: Int, isLiked: Bool)
    func setSearchBarDelegate(vc: MainViewController)
    func setCollectionViewDelegate(vc: MainViewController)
    func setCollectionViewDataSource(vc: MainViewController)
}

class MainViewController: CustomViewController<MainView> {
    
    var presenter: MainPresenterProtocol!
    var mainView: MainVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        presenter.checkCouruselFavorite()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.checkSelectedCategoriesRecommdations()
    }
   
    private func setDelegates(){
        customView.delegate = self
        mainView = customView
        mainView?.setCollectionViewDelegate(vc: self)
        mainView?.setSearchBarDelegate(vc: self)
        mainView?.setCollectionViewDataSource(vc: self)
    }
}
//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func reloadOneCell(indexItem: Int, isLiked: Bool) {
        mainView?.changeFavoriteCelButtonBackGround(indexItem: indexItem, isLiked: isLiked)
    }
    
    func reloadSectionCollectionView(section: Int) {
        mainView?.reloadCollectionView(section: section)
    }
    
    func reloadCollectionView() {
        mainView?.reloadCollectionView()
    }
    
    func showAlert(error: String) {
        AuthAlertManager.shared.showDefaultAlert(on: self, title: "Warning", message: error)
    }
}
//MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate{
    func getData() -> [ListSectionModel] {
        presenter.sectionsData
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.sectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch presenter.sectionsData[section]{
        case .categories:
            return presenter.categoriesArray.count
        case .corusel:
            return presenter.newsDataByCatagory.count
        case .recomendations:
            return presenter.recomendedNews.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = presenter.sectionsData[indexPath.section]
        switch sections{
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.resuseID, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
            cell.configCell(categoryLabelText:  presenter.categoriesArray[indexPath.row].categoryLabel, emojiString: nil, categoriesValue: presenter.categoriesArray[indexPath.row].categoryValue)
            presenter?.selectedIndexPath == indexPath ?  cell.setSelectedColors() : cell.setDefaultColors()// меняет цвет для выбранных при переиспользовании ячейки
            return cell
        case .corusel:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCouruselCell.resuseID, for: indexPath) as? ArticleCouruselCell else { return UICollectionViewCell() }
            let data = presenter.newsDataByCatagory[indexPath.row]
            let filterCategory = presenter.filterCategoriesForSelectedCategory(categories: data.category)
            let currentIndexPath = indexPath
            if let cachedImage = presenter.imageCacheCourusel[currentIndexPath] {
                cell.configCell(categoryLabelText: filterCategory, articleNameText: data.title, image: cachedImage, isLiked: data.isFavourite)
            } else {
                presenter.loadImageByCategories(imageUrl: data.imageUrl, completion: {[currentIndexPath] image in
                    let imageToUse = image ?? UIImage.Images.noImage
                    self.presenter.imageCacheCourusel[currentIndexPath] = imageToUse
                    if let visibleCell = collectionView.cellForItem(at: currentIndexPath) as? ArticleCouruselCell {
                        visibleCell.configCell(categoryLabelText: filterCategory, articleNameText: data.title, image: imageToUse, isLiked: data.isFavourite)
                    }
                })
                cell.configCell(categoryLabelText: filterCategory, articleNameText: data.title, image: nil, isLiked: data.isFavourite)
            }
            cell.onFavoriteButtonTap = { [weak self] event in
                self?.presenter.handleCellEvent(article: indexPath.row, event: event) { error in
                    if error != nil {
                        print("Error is occured during removing article from favorite")
                    }
                }
            }
            return cell
        case .recomendations:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendedCell.resuseID, for: indexPath) as? RecomendedCell else { return UICollectionViewCell() }
            let data = presenter.recomendedNews[indexPath.row]
            let categoryFilter = presenter.filterCategoriesArray(categories: data.category)
            let currentIndexPath = indexPath
            if let cachedImage = presenter.imageCacheRecomendation[currentIndexPath] {
                cell.configCell(categoryLabelText: categoryFilter, articleNameText: data.title, image: cachedImage)
            } else {
                presenter.loadImageByCategories(imageUrl: data.imageUrl, completion: { [currentIndexPath] image in
                    let imageToUse = image ?? UIImage.Images.noImage
                    self.presenter.imageCacheRecomendation[currentIndexPath] = imageToUse
                    if let visibleCell = collectionView.cellForItem(at: currentIndexPath) as? RecomendedCell {
                        visibleCell.configCell(categoryLabelText: categoryFilter, articleNameText: data.title, image: imageToUse)
                    }
                })
                cell.configCell(categoryLabelText: categoryFilter, articleNameText: data.title, image: nil)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderRecomendedView.resuseID, for: indexPath) as? HeaderRecomendedView else { return UICollectionReusableView()}
            let data = presenter.sectionsData
            header.configureHeader(sectionTitle: data[indexPath.section].title)
            header.delegate = self
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch presenter.sectionsData[indexPath.section]{
        case .categories:
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell {
                if let previousCell = collectionView.cellForItem(at: presenter.selectedIndexPath) as? CategoriesCell {
                    previousCell.setDefaultColors()
                }
                cell.setSelectedColors()
                presenter.saveSelectedCell(indexPath: indexPath)
                
                presenter.selectedCategory = presenter.categoriesArray[indexPath.row].categoryValue
                presenter.imageCacheCourusel = [:] //чистим словарь перед сменой категории
                presenter.getNewsByCategory(category: presenter.categoriesArray[indexPath.row].categoryValue)
            }
        case .corusel:
            presenter.goToDetailVC(data: presenter.newsDataByCatagory[indexPath.row])
        case .recomendations:
            presenter.goToDetailVC(data: presenter.recomendedNews[indexPath.row])
        }
    }
}

//MARK: - HeaderButton SeeAll
extension MainViewController: HeaderRecomendedViewDelegate {
    func tappedSeeAllButton() {
        presenter.goToRecomendedVC()
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        presenter.goToSearchByWorldVC(searchWord: searchText)
        searchBar.resignFirstResponder()
    }
}

