//
//  MainViewController.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

class MainViewController: CustomViewController<MainView> {
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setDelegates(){
        customView.delegate = self
        customView.collectionViewDelegate = self
        customView.searchBarDelegate = self
    }
    
}
//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    
}
//MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate{
    func getData() -> [ListSectionModel] {
        presenter?.mockData ?? []
    }
    
    func tappedSeeAllButton() {
        print("Tapped SeeAll")
    }
    
    func tappedFavoriteButton() {
        print("Tapped Favorite")
    }
}
//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch presenter?.mockData[indexPath.section]{
        case .categories(let gategories):
            print("gategories \(gategories[indexPath.row].articleCategory)")
        case .corusel(let corusel):
            print("corusel \(corusel[indexPath.row].articleName)")
        case .recomendations(let recomendations):
            print("recomendations \(recomendations[indexPath.row].articleCategory)")
        case .none:
            print("none case tapped")
        }
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

