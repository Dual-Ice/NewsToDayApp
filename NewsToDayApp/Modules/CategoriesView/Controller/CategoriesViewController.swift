//
//  CategoriesViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//


import UIKit

protocol CategoriesVCDelegate{
    func setCollectionViewDelegate(vc: CategoriesViewController)
    func setCollectionViewDataSource(vc: CategoriesViewController)
    func nextButtonConfigurate(mode: CategoriesViewMode?)
    func reloadCategoriesCollection()
}

class CategoriesViewController: CustomViewController<CategoriesView> {
    
    var presenter: CategoriesPresenterProtocol!
    let categoriesMode: CategoriesViewMode
    private var categoriesView: CategoriesVCDelegate?
    
    init(mode: CategoriesViewMode) {
        self.categoriesMode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        if self.categoriesMode == .categoriesOnbording {
            UserDefaults.standard.removeObject(forKey: "isOnboardingCompleted")
            UserDefaults.standard.removeObject(forKey: "onboardingCategories")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("willDISappear")

        presenter.saveCategoriesArray(categoriesMode: categoriesMode) { error in
            if let error = error {
                print("Error is occured during categories saving")
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // fix this line
        presenter.setSelectedColorForOnbordingSelection(selectedCategories: UserManager.shared.getCategories())
    }
    
    private func setDelegates(){
        customView.delegate = self
        categoriesView = customView
        categoriesView?.setCollectionViewDelegate(vc: self)
        categoriesView?.setCollectionViewDataSource(vc: self)
        categoriesView?.nextButtonConfigurate(mode: categoriesMode)
    }
    
}
//MARK: - CategoriesPresenterViewProtocol
extension CategoriesViewController: CategoriesPresenterViewProtocol {
    func reloadCollectionView() {
        categoriesView?.reloadCategoriesCollection()
    }
    
    func checkAuth() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}
//MARK: - CategoriesViewDelegate
extension CategoriesViewController: CategoriesViewDelegate {
    func tappedNextButton() {
        presenter.tappedNextButton()
    }
}

//MARK: - UICollectionViewDataSource
extension CategoriesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.resuseID, for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }
        let data = presenter.data[indexPath.row]
        cell.configCell(categoryLabelText: data.categoryLabel, emojiString: data.emojy, categoriesValue: data.categoryValue)
        presenter.selectedIndexPathArray.contains(indexPath) ?  cell.setSelectedColors() :  cell.setDefaultColors() //меняем цвет для выбранных категорий при первой загрузки и с учетом переиспользования
        return cell
    }
    
}
//MARK: - UICollectionViewDelegate
extension CategoriesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCell {
            if let indexPathToRemove = presenter?.selectedIndexPathArray.first(where: { $0 == indexPath }) {
                cell.setDefaultColors()
                presenter.removeUnSelectedCell(indexPath: indexPathToRemove, category: cell.categoryTitle)
            } else {
                cell.setSelectedColors()
                presenter.saveSelectedCell(indexPath: indexPath, category: cell.categoryTitle)
            }
            presenter.checkCategoriesQuantity()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // from left and right of the screen
        let minimumItemSpacing: CGFloat = 16 // between columns
        let availableWidth = customView.bounds.width - (padding * 2) - (minimumItemSpacing)
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}

