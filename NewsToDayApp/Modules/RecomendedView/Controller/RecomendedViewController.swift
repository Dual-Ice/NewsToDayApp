//
//  RecomendedViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import UIKit

protocol RecomendedVCDelegate{
    func reloadTableView()
    func setTableDelegate(vc: RecomendedViewController)
    func setTableViewDataSource(vc: RecomendedViewController)
}

class RecomendedViewController: CustomViewController<RecomendedView> {
    
    var presenter: RecomendedPresenterProtocol?
    var recomendedView: RecomendedVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
        presenter?.dismisRecomendedVC()
    }
}

//MARK: - UITableViewDataSource
extension RecomendedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.data.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarksCell.resuseID, for: indexPath) as? BookmarksCell else {return UITableViewCell()}
        let data = presenter?.data[indexPath.row]
        cell.selectionStyle = .none
        presenter?.loadImage(imageUrl: data?.imageUrl, completion: { image in
            let imageToUse = image ?? UIImage(named: "noImage")
            cell.configCell(categoryLabelText: data?.category.joined(separator: ","), articleNameText: data?.title, image: imageToUse)
        })
        cell.configCell(categoryLabelText: data?.category.joined(separator: ","), articleNameText: data?.title, image: nil)
        return cell
    }

}
//MARK: - UITableViewDelegate
extension RecomendedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToDetailVC(data: presenter?.data[indexPath.row], isLiked: presenter?.data[indexPath.row].isFavourite ?? false)
    }
}
