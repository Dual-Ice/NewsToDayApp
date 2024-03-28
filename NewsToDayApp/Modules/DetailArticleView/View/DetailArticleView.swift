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
    
   // private let categoryLabel = LabelsFactory.makeCategoryTagLabel()
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
    
    private lazy var  stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
      
    
    private let favoriteButton = ButtonsFactory.makeButton()
    private let backButton = ButtonsFactory.makeButton()
    private let shareButton = ButtonsFactory.makeButton()
    private let spinner = SpinnersFactory.makeSpinner()
    
    //MARK: - ConfigView public method
    func configView(data: Article?, isLiked: Bool?, image: UIImage?){
        //MARK: - config backImage
        if let image = image{
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            backImage.image = image
        } else{
            setUpSpiner()
            backImage.backgroundColor = .none
        }
        //MARK: - config favoriteButton
        let favoriteImage: UIImage? = isLiked ?? false ? UIImage.Icons.bookmarkFill : UIImage.Icons.bookmarkEmpty
        favoriteButton.setBackgroundImage(favoriteImage, for: .normal)
        //MARK: - config Labels
        createStackViewLabels(categories: data?.category ?? [])
        //categoryLabel.text = data?.category.joined(separator: ",").uppercased()
        articleNameLabel.text = data?.title
        authorNameLabel.text = data?.creator?.joined(separator: ",")  ?? ""
        //MARK: - config newsText
        let descriptionText = data?.description ?? "No Description"
        let repeatedText = String(repeating: descriptionText, count: 10)
        newsText.text = repeatedText
    }
    
    private func createStackViewLabels(categories: [String]){
        let translatedCategories = categories.translateCategories(filteredCategory: categories)
        for category in translatedCategories {
            if stackView.arrangedSubviews.count < 3 {
                let label =  PaddingLabel(withInsets: 0, 0, 5, 5)
                label.text = category
                label.textAlignment = .center
                label.backgroundColor = UIColor(named: ConstColors.purplePrimary)
                label.font = UIFont.TextFont.Main.tag
                label.numberOfLines = 1
                label.textColor = UIColor(named: ConstColors.customWhite)
                label.layer.cornerRadius = 16
                label.layer.masksToBounds = true
                stackView.addArrangedSubview(label)
            }
        }
    }
    
    private func setUpSpiner(){
        spinner.color = .white
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerY.equalTo(backImage.snp.centerY)
            make.centerX.equalTo(backImage.snp.centerX)
        }
        spinner.startAnimating()
    }
    
    override func setViews() {
        setUpViews()
        backgroundColor = .white
        backImage.addSubview(backView)
        [
            backImage,
            stackView,
            //categoryLabel,
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
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(articleNameLabel.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(16)
            //make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
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
            make.trailing.equalToSuperview().offset(-8)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(favoriteButton.snp.bottom).offset(28)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(28)
        }
        
    }
    
    private func setUpViews(){
        //MARK: - setUp Images
        backImage.layer.cornerRadius = 0
        //MARK: - setUp Labels
        articleNameLabel.font = UIFont.TextFont.Article.articleLabel
        articleNameLabel.numberOfLines = 3
        authorNameLabel.font = UIFont.TextFont.Article.authorName
        authorLabel.font = UIFont.TextFont.Article.authorLabel
        authorLabel.text = NSLocalizedString("DetailArticleViewAuthor", comment: "")
        resultLabel.textColor = UIColor(named: ConstColors.blackPrimary)
        resultLabel.font = UIFont.TextFont.Main.recommendedArticleLabel
        resultLabel.text = NSLocalizedString("DetailArticleViewResult", comment: "")
//        categoryLabel.textAlignment = .center
//        categoryLabel.backgroundColor = UIColor(named: ConstColors.purplePrimary)
//        categoryLabel.layer.cornerRadius = 16
//        categoryLabel.layer.masksToBounds = true
        //MARK: - setUp Buttons
        favoriteButton.backgroundColor = .clear
        favoriteButton.addTarget(nil, action: #selector(favoriteTapped), for: .touchUpInside)
        favoriteButton.setBackgroundImage(UIImage.Icons.book, for: .normal)
        favoriteButton.tintColor = UIColor(named: ConstColors.customWhite)
        backButton.backgroundColor = .clear
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .white
        shareButton.backgroundColor = .clear
        shareButton.addTarget(nil, action: #selector(shareTapped), for: .touchUpInside)
        shareButton.setBackgroundImage(UIImage.Icons.share, for: .normal)
        shareButton.tintColor = UIColor(named: ConstColors.customWhite)
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

// MARK: - DetailArticleVCDelegate
extension DetailArticleView: DetailArticleVCDelegate{
    func changeBacgroundImageButton(isLiked: Bool) {
        let favoriteImage: UIImage? = isLiked ? UIImage.Icons.bookmarkFill : UIImage.Icons.bookmarkEmpty
        favoriteButton.setBackgroundImage(favoriteImage, for: .normal)
    }
}
