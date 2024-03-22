//
//  BookmarksViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit

protocol BookmarksVCDelegate{
    func reloadTableView()
    func setTableDelegate(vc: BookmarksViewController)
    func setTableViewDataSource(vc: BookmarksViewController)
    func emptyBookmarsTrue()
    func emptyBookmarsFalse()
}

class BookmarksViewController: CustomViewController<BookmarksView> {
    
    var presenter: BookmarksPresenterProtocol?
    var bookmarksView: BookmarksVCDelegate?
    
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
        bookmarksView = customView
        bookmarksView?.setTableDelegate(vc: self)
        bookmarksView?.setTableViewDataSource(vc: self)
        presenter?.checkBookmarks()
    }
    
}
//MARK: - BookmarksPresenterViewProtocol
extension BookmarksViewController: BookmarksPresenterViewProtocol {
    func emptyBookmarks() {
        bookmarksView?.emptyBookmarsTrue()
    }
    
    func fullBookmarks() {
        bookmarksView?.emptyBookmarsFalse()
    }
}

//MARK: - BookmarksViewDelegate
extension BookmarksViewController: BookmarksViewDelegate{
    
}
//MARK: - UITableViewDataSource
extension BookmarksViewController: UITableViewDataSource{
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
extension BookmarksViewController: UITableViewDelegate{
    
}
