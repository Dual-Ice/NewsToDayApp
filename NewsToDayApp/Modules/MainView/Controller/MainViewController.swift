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
    func setSearchBarDelegate(vc: MainViewController)
    func setCollectionViewDelegate(vc: MainViewController)
    func setCollectionViewDataSource(vc: MainViewController)
}

class MainViewController: CustomViewController<MainView> {
    
    var presenter: MainPresenterProtocol?
    var mainView: MainVCDelegate?
    //var previouslySelectedIndexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        presenter?.getNewsByCategory(category: "Business")
        presenter?.getRecomendedNews(categoryArray: ["Science", "Health"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
    func reloadSectionCollectionView(section: Int) {
        mainView?.reloadCollectionView(section: section)
    }
    
    func reloadCollectionView() {
        mainView?.reloadCollectionView()
    }
}
//MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate{
    func getData() -> [ListSectionModel] {
        presenter?.mockData ?? []
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.mockData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let presenter{
            switch presenter.mockData[section]{
            case .categories(let categories):
                return categories.count
            case .corusel(_):
                return presenter.newsDataByCatagory.count
            case .recomendations(_):
                return presenter.recomendedNews.count
            }
        }else{
            return 0
        }
        //return presenter?.mockData[section].countData ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = presenter?.mockData[indexPath.section]
        switch sections{
        case .categories(let categories):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.resuseID, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
            cell.configCell(categoryLabelText: categories[indexPath.row].articleCategory, emojiString: nil)
            presenter?.selectedIndexPath == indexPath ?  cell.setSelectedColors() : cell.setDefaultColors()// меняет цвет при переиспользовании ячейки
            return cell
        case .corusel(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCouruselCell.resuseID, for: indexPath) as? ArticleCouruselCell else { return UICollectionViewCell() }
            let data = presenter?.newsDataByCatagory[indexPath.row]
            let favoriteData = presenter?.favorities
            presenter?.loadImageByCategories(imageUrl: data?.imageUrl, completion: { image in
                let categoryText = self.presenter?.convertToString(arrayStrings: data?.category ?? [])
                let articleNameText = data?.title
                let isLiked = data?.isFavourite ?? false
                let imageToUse = image ?? UIImage(named: "noImage")

                cell.configCell(categoryLabelText: categoryText, articleNameText: articleNameText, image: imageToUse, isLiked: isLiked)
            })
            cell.configCell(categoryLabelText: presenter?.convertToString(arrayStrings: data?.category ?? []), articleNameText: data?.title, image: nil, isLiked: data?.isFavourite ?? false) //favoriteData?[data] ?? false
//            cell.onFavoriteButtonTap = { [weak self] event in
//                self?.presenter?.handleCellEvent(article: data, event: event)
//            }
            return cell
        case .recomendations(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendedCell.resuseID, for: indexPath) as? RecomendedCell else { return UICollectionViewCell() }
            let data = presenter?.recomendedNews[indexPath.row]
            presenter?.loadImageByCategories(imageUrl: data?.imageUrl, completion: { image in
                let categoryText = self.presenter?.convertToString(arrayStrings: data?.category ?? [])
                let articleNameText = data?.title
                let imageToUse = image ?? UIImage(named: "noImage")
                cell.configCell(categoryLabelText: categoryText, articleNameText: articleNameText, image: imageToUse)
            })
            cell.configCell(categoryLabelText: presenter?.convertToString(arrayStrings: data?.category ?? []), articleNameText: data?.title, image: nil)
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderRecomendedView.resuseID, for: indexPath) as? HeaderRecomendedView else { return UICollectionReusableView()}
            let data = presenter?.mockData
            header.configureHeader(sectionTitle: data?[indexPath.section].title ?? "")
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
        switch presenter?.mockData[indexPath.section]{
        case .categories(let gategories):
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell, let previosIndex = presenter?.selectedIndexPath {
                if let previousCell = collectionView.cellForItem(at: previosIndex) as? CategoriesCell {
                    previousCell.setDefaultColors()
                }
                cell.setSelectedColors()
                presenter?.saveSelectedCell(indexPath: indexPath)
                presenter?.getNewsByCategory(category: gategories[indexPath.row].articleCategory)
            }
        case .corusel(let corusel):
            //let favorite = presenter?.favorities[corusel[indexPath.row]]
            presenter?.goToDetailVC(data: presenter?.newsDataByCatagory[indexPath.row], isLiked: false) //favorite ?? false
        case .recomendations(_):
            presenter?.goToDetailVC(data: presenter?.recomendedNews[indexPath.row], isLiked: false)
        case .none:
            print("none case tapped")
        }
    }
}

//MARK: - HeaderButton SeeAll
extension MainViewController: HeaderRecomendedViewDelegate {
    func tappedSeeAllButton() {
        print("Tapped SeeAll")
        presenter?.goToRecomendedVC()
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        print(searchText)
        searchBar.resignFirstResponder()
    }
}

