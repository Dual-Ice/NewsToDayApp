//
//  OnbordingView.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//

import UIKit

protocol OnbordingViewDelegate: AnyObject {
    func tappedNextButton()
    
}

final class OnbordingView: CustomView{
    weak var delegate: OnbordingViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private let buttonNext = ButtonsFactory.makeButton()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor(named: ConstColors.purplePrimary)
        pageControl.pageIndicatorTintColor = UIColor(named: ConstColors.greyLight)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    override func setViews(){
        setUpViews()
        configureCollectionView()
        [
            collectionView,
            buttonNext,
            pageControl,
        ].forEach { addSubview($0) }
    }
    
    private func setUpViews(){
        buttonNext.setTitle(NSLocalizedString("OnbordingNext", comment: ""), for: .normal)
        buttonNext.setTitleColor(UIColor(named: ConstColors.customWhite), for: .normal)
        buttonNext.titleLabel?.font = UIFont.TextFont.Screen.button
        buttonNext.addTarget(nil, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OnbordingCell.self, forCellWithReuseIdentifier: OnbordingCell.resuseID)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    @objc private func tappedButton(){
        delegate?.tappedNextButton()
    }
    
    override func layoutViews() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(76)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(pageControl.snp.top).offset(-16)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(buttonNext.snp.top).offset(-32)
            make.height.equalTo(30)
            
        }
        buttonNext.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
    }
}


// MARK: - OnbordingViewVCDelegate
extension OnbordingView: OnbordingViewVCDelegate{
    func changeButtonTitleToNext() {
        buttonNext.setTitle(NSLocalizedString("OnbordingNext", comment: ""), for: .normal)
    }
    
    func scrollToIndexPath(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func changeButtonTitleFromNext() {
        buttonNext.setTitle(NSLocalizedString("OnbordingGetStarted", comment: ""), for: .normal)
    }
    
    func updatePageControllPage(page: Int) {
        pageControl.currentPage = page
    }
    
    func setCollectionViewDelegate(vc: OnbordingViewController) {
        collectionView.delegate = vc
        
    }
    
    func setCollectionViewDataSource(vc: OnbordingViewController) {
        collectionView.dataSource = vc
    }
}
