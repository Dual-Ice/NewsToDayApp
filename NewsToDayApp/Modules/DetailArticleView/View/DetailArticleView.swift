//
//  DetailArticleView.swift
//  NewsToDayApp
//
//  Created by Polina on 20.03.2024.
//

import UIKit

protocol DetailArticleViewDelegate: AnyObject {
    func tappedBackButton()
    func tappedFavoriteButton()
    func tappedShareButton()
}

final class DetailArticleView: CustomView {
    
    weak var delegate: DetailArticleViewDelegate?
    
    private let backImage = ImageViewFactory.makeCornerRadiusImage()
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryLabel = LabelsFactory.makeCategoryTagLabel()
    private let categoryLabeImage = ImageViewFactory.makeCornerRadiusImage()
    private let articleNameLabel = LabelsFactory.makeArticleHeaderLabel()
    private let authorNameLabel = LabelsFactory.makeArticleHeaderLabel()
    private let authorLabel = LabelsFactory.makeCategoryLabel()
    private let resultLabel = LabelsFactory.makeArticleHeaderLabel()
    
    private lazy var newsText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.text = ""
        textView.textColor = UIColor(named: ConstColors.greyDarker)
        textView.font = UIFont.TextFont.Article.articleText
        textView.textAlignment = .left
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    private let favoriteButton = ButtonsFactory.makeButton()
    private let backButton = ButtonsFactory.makeButton()
    private let shareButton = ButtonsFactory.makeButton()
    
    //MARK: - ConfigView public method
    func configView(data: OneItem, isLiked: Bool){
        //MARK: - config backImage
        let image = UIImage(named: data.image ?? "")
        if let image = image{
            backImage.image = image
        } else{
            backImage.backgroundColor = .blue
        }
        //MARK: - config favoriteButton
        let favoriteImage: UIImage? = isLiked ? UIImage(named: "bookmark-selected") : UIImage(named: "bookmark-bordered")
        favoriteButton.setBackgroundImage(favoriteImage, for: .normal)
        //MARK: - config Labels
        categoryLabel.text = data.articleCategory
        articleNameLabel.text = data.articleName
        authorNameLabel.text = "Default Author"
        //MARK: - config newsText
        newsText.text = """
        Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.
        
        For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.

        Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.

        For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.
        Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.

        For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters.
"""
    }
    
    override func setViews() {
        setUpViews()
        backgroundColor = .white
        backImage.addSubview(backView)
        categoryLabeImage.addSubview(categoryLabel)
        [
            backImage,
            categoryLabeImage,
            articleNameLabel,
            authorNameLabel,
            authorLabel,
            favoriteButton,
            resultLabel,
            newsText,
            backButton,
            shareButton,
        ].forEach { addSubview($0) }
    }
    
    override func layoutViews() {
        backImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(384)
        }
    
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(categoryLabeImage.snp.centerX)
            make.centerY.equalTo(categoryLabeImage.snp.centerY)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        newsText.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backImage.snp.bottom).offset(-32)
            make.leading.equalToSuperview().offset(16)
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(authorLabel.snp.top).offset(-8)
            make.leading.equalToSuperview().offset(16)
        }
        
        articleNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(authorNameLabel.snp.top).offset(-32)
            make.leading.equalToSuperview().offset(16)
        }
        
        categoryLabeImage.snp.makeConstraints { make in
            make.bottom.equalTo(articleNameLabel.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(75)
            make.height.equalTo(32)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(favoriteButton.snp.bottom).offset(32)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
    }
    
    private func setUpViews(){
        //MARK: - setUp Images
        backImage.layer.cornerRadius = 0
        categoryLabeImage.layer.cornerRadius = 16
        categoryLabeImage.backgroundColor = UIColor(named: ConstColors.purplePrimary)
        //MARK: - setUp Labels
        articleNameLabel.font = UIFont.TextFont.Article.articleLabel
        authorNameLabel.font = UIFont.TextFont.Article.authorName
        authorLabel.font = UIFont.TextFont.Article.authorLabel
        authorLabel.text = NSLocalizedString("DetailArticleViewAuthor", comment: "")
        resultLabel.textColor = UIColor(named: ConstColors.blackPrimary)
        resultLabel.font = UIFont.TextFont.Main.recommendedArticleLabel
        resultLabel.text = NSLocalizedString("DetailArticleViewResult", comment: "")
        //MARK: - setUp Buttons
        favoriteButton.backgroundColor = .clear
        favoriteButton.addTarget(nil, action: #selector(favoriteTapped), for: .touchUpInside)
        favoriteButton.setBackgroundImage(UIImage(named: "bookmark-light"), for: .normal)
        backButton.backgroundColor = .clear
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .white
        shareButton.backgroundColor = .clear
        shareButton.addTarget(nil, action: #selector(shareTapped), for: .touchUpInside)
        shareButton.setBackgroundImage(UIImage(named: "share"), for: .normal)
    }
    
    @objc private func favoriteTapped(){
        delegate?.tappedFavoriteButton()
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
    
    @objc private func shareTapped(){
        delegate?.tappedShareButton()
    }
}
