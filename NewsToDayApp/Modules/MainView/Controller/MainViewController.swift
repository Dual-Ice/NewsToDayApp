//
//  MainViewController.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol MainVCDelegate{
    func reloadCollectionView()
    func setSearchBarDelegate(vc: MainViewController)
    func setCollectionViewDelegate(vc: MainViewController)
    func setCollectionViewDataSource(vc: MainViewController)
}

class MainViewController: CustomViewController<MainView> {
    
    var presenter: MainPresenterProtocol?
    var mainView: MainVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
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
        return presenter?.mockData[section].countData ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = presenter?.mockData[indexPath.section]
        switch sections{
        case .categories(let categories):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.resuseID, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
            cell.configCell(categoryLabelText: categories[indexPath.row].articleCategory)
            presenter?.selectedIndexPath == indexPath ?  cell.setSelectedColors() : cell.setDefaultColors()
            return cell
        case .corusel(let corusel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCouruselCell.resuseID, for: indexPath) as? ArticleCouruselCell else { return UICollectionViewCell() }
            let data = corusel[indexPath.row]
            let favoriteData = presenter?.favorities
            cell.configCell(categoryLabelText: data.articleCategory, articleNameText: data.articleName, image: UIImage(named: data.image ?? "DefaultImage"), isLiked: favoriteData?[data] ?? false )
            cell.onFavoriteButtonTap = { [weak self] event in
                self?.presenter?.handleCellEvent(article: data, event: event)
            }
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
            presenter?.saveSelectedCell(indexPath: indexPath)
            mainView?.reloadCollectionView() // запрос в сеть и в нем уже  reloadCollectionView
            print("gategories \(gategories[indexPath.row].articleCategory ?? "")")
        case .corusel(let corusel):
            let favorite = presenter?.favorities[corusel[indexPath.row]]
//            presenter?.goToDetailVC(data: corusel[indexPath.row], isLiked: favorite ?? false)
            let detailVC = DetailArticleViewController(data: corusel[indexPath.row], isLiked: favorite ?? false)
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true)
           // print("corusel \(corusel[indexPath.row].articleName ?? "")")
        case .recomendations(let recomendations):
            print("recomendations \(recomendations[indexPath.row].articleCategory ?? "")")
        case .none:
            print("none case tapped")
        }
    }
}

//MARK: - HeaderButton SeeAll
extension MainViewController: HeaderRecomendedViewDelegate {
    func tappedSeeAllButton() {
        print("Tapped SeeAll")
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

