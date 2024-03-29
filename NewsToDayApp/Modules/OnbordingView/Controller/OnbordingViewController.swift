//
//  OnbordingViewController.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//


import UIKit

protocol OnbordingViewVCDelegate{
    func setCollectionViewDelegate(vc: OnbordingViewController )
    func setCollectionViewDataSource(vc: OnbordingViewController )
    func updatePageControllPage(page: Int)
    func changeButtonTitleFromNext()
    func changeButtonTitleToNext()
    func scrollToIndexPath(indexPath: IndexPath)
}

final class OnbordingViewController: CustomViewController<OnbordingView> {
    
    var presenter: OnbordingPresenterProtocol!
    var onbordingView: OnbordingViewVCDelegate?
    
    private var currentPage = 0 {
        didSet{
            onbordingView?.updatePageControllPage(page: currentPage)
            if currentPage == presenter.data.count - 1{
                onbordingView?.changeButtonTitleFromNext()
            } else {
                onbordingView?.changeButtonTitleToNext()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDelegates()
    }
    
    private func setDelegates(){
        customView.delegate = self
        onbordingView = customView
        onbordingView?.setCollectionViewDataSource(vc: self)
        onbordingView?.setCollectionViewDelegate(vc: self)
        
    }
}
// MARK: - OnbordingViewDelegate
extension OnbordingViewController: OnbordingViewDelegate{
    func tappedNextButton() {
        if currentPage == presenter.data.count - 1{
            presenter.goToCategoriesVC()
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onbordingView?.scrollToIndexPath(indexPath: indexPath)
        }
    }
}

// MARK: - OnbordingPresenterViewProtocol
extension OnbordingViewController: OnbordingPresenterViewProtocol{
//    func checkAuth() {
//        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//            sceneDelegate.checkAuthentication()
//        }
//    }
    func goToCategories() {
        let vc = CategoriesBuilder().buildCategoriesView(mode: .categoriesOnbording)
        vc.modalPresentationStyle = .fullScreen
        self.view?.window?.rootViewController = vc
    }
}

// MARK: - UICollectionViewDelegate
extension OnbordingViewController: UICollectionViewDelegate{
    
}

// MARK: - UICollectionViewDataSource
extension OnbordingViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnbordingCell.resuseID, for: indexPath) as? OnbordingCell else { return UICollectionViewCell() }
        let data = presenter.data[indexPath.row]
        cell.configCell(titleText: data.title, descriptionText: data.description, image: UIImage(named: data.image)!)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnbordingViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

