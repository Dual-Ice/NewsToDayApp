//
//  RecomendedViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import UIKit

protocol RecomendedVCDelegate{
    func setTableDelegate(vc: RecomendedViewController)
    func setTableViewDataSource(vc: RecomendedViewController)
    func reloadTableView()
}

class RecomendedViewController: CustomViewController<RecomendedView> {
    
    var presenter: RecomendedPresenterProtocol!
    var recomendedView: RecomendedVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.imageCacheRecomendation = [:] // чистим словарь с картинка
    }
    
    private func setDelegates(){
        customView.delegate = self
        recomendedView = customView
        recomendedView?.setTableDelegate(vc: self)
        recomendedView?.setTableViewDataSource(vc: self)
    }
    
}
//MARK: - RecomendedPresenterViewProtocol
extension RecomendedViewController: RecomendedPresenterViewProtocol {
    func reloadTableView() {
        recomendedView?.reloadTableView()
    }
}

//MARK: - RecomendedViewDelegate
extension RecomendedViewController: RecomendedViewDelegate{
    func tappedBackButton() {
        presenter.dismisRecomendedVC()
    }
}

//MARK: - UITableViewDataSource
extension RecomendedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarksCell.resuseID, for: indexPath) as? BookmarksCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        let data = presenter.data[indexPath.row]
        let filterCategories = presenter.filterCategoriesArray(categories: data.category)
        let currentIndexPath = indexPath
        if let cachedImage = presenter.imageCacheRecomendation[currentIndexPath] {
            cell.configCell(categoryLabelText: filterCategories.joined(separator: ","), articleNameText: data.title, image: cachedImage)
        } else {
            presenter.loadImage(imageUrl: data.imageUrl, completion: { [currentIndexPath] image in
                let imageToUse = image ?? UIImage.Images.noImage
                self.presenter.imageCacheRecomendation[currentIndexPath] = imageToUse
                if let visibleCell = tableView.cellForRow(at: currentIndexPath) as? BookmarksCell {
                    visibleCell.configCell(categoryLabelText: filterCategories.joined(separator: ","), articleNameText: data.title, image: imageToUse)
                }
            })
            cell.configCell(categoryLabelText: filterCategories.joined(separator: ","), articleNameText: data.title, image: nil)
        }
        return cell
//        presenter?.loadImage(imageUrl: data.imageUrl, completion: { image in
//            let imageToUse = image ?? UIImage.Images.noImage
//            cell.configCell(categoryLabelText: filterCategories.joined(separator: ","), articleNameText: data.title, image: imageToUse)
//        })
//        cell.configCell(categoryLabelText: filterCategories.joined(separator: ","), articleNameText: data.title, image: nil)
   
    }

}
//MARK: - UITableViewDelegate
extension RecomendedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToDetailVC(data: presenter.data[indexPath.row])
    }
}
