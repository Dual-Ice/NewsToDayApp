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
        navigationController?.navigationBar.isHidden = false
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
  
}

//MARK: - RecomendedViewDelegate
extension RecomendedViewController: RecomendedViewDelegate{
    
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
        cell.configCell(categoryLabelText: data?.articleCategory, articleNameText: data?.articleName, image: UIImage(named: data?.image ?? ""))
        return cell
    }

}
//MARK: - UITableViewDelegate
extension RecomendedViewController: UITableViewDelegate{
    
}
