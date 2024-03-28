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
    
    var presenter: BookmarksPresenterProtocol!
    var bookmarksView: BookmarksVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        presenter.checkBookmarks()
        presenter.getSaveAtricles()
    }
    
    private func setDelegates(){
        customView.delegate = self
        bookmarksView = customView
        bookmarksView?.setTableDelegate(vc: self)
        bookmarksView?.setTableViewDataSource(vc: self)
    }
    
}
//MARK: - BookmarksPresenterViewProtocol
extension BookmarksViewController: BookmarksPresenterViewProtocol {
    func reloadTableView() {
        bookmarksView?.reloadTableView()
    }
    
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
        presenter.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarksCell.resuseID, for: indexPath) as? BookmarksCell else {return UITableViewCell()}
        let data = presenter.data[indexPath.row]
        cell.selectionStyle = .none
//        cell.configCell(categoryLabelText: data.articleCategoryLabel, articleNameText: data.articleName, image: UIImage(named: data.image))
        // когда будут данные не моковые расскоментировать
        let filterCategories = presenter.filterCategoriesArray(categories: data.category)
        presenter.loadImage(imageUrl: data.imageUrl, completion: { image in
            let imageToUse = image ?? UIImage(named: "noImage")
            cell.configCell(categoryLabelText: filterCategories.joined(separator: ","), articleNameText: data.title, image: imageToUse)
        })
        cell.configCell(categoryLabelText: filterCategories.joined(separator: ","), articleNameText: data.title, image: nil)
        return cell
    }

}
//MARK: - UITableViewDelegate
extension BookmarksViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          let data = presenter.data[indexPath.row]
//          presenter.deleteOneArticle(articleId: data.articleId) // это для мок данных
          presenter.deleteOneArticle(articleId: data.articleId) // подставить presenter.data[indexPath.row].articleId
          tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToDetailVC(data: presenter.data[indexPath.row])
    }
}
