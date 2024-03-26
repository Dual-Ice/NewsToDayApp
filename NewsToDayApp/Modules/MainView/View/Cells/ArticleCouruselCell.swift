//
//  ArticleCouruselCell.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import UIKit
import SnapKit

protocol ArticleCouruselCellDelegate: AnyObject {
    func tappedFavoriteButton()
}

enum FavoriteButtonCellEvent {
    case favoriteDidTapped
}

class ArticleCouruselCell: UICollectionViewCell {
    static let resuseID = "ArticleCouruselCell"
    //weak var delegate: ArticleCouruselCellDelegate?
    var onFavoriteButtonTap: ((FavoriteButtonCellEvent) -> Void)?
    
    private let categoryLabel = LabelsFactory.makeCategoryLabel()
    private let articleNameLabel = LabelsFactory.makeArticleHeaderLabel()
    private let backImage = ImageViewFactory.makeCornerRadiusImage()
    private let favoriteButton = ButtonsFactory.makeButton()
    private lazy var spinner = SpinnersFactory.makeSpinner()
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setViews()
        layoutViews()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        articleNameLabel.text = nil
        backImage.image = nil
    }
    
    private func setUpViews(){
        favoriteButton.backgroundColor = .clear
        favoriteButton.addTarget(nil, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    private func setUpSpiner(){
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerY.equalTo(backImage.snp.centerY)
            make.centerX.equalTo(backImage.snp.centerX)
        }
        spinner.startAnimating()
    }
    
    @objc private func favoriteTapped(){
        let event = FavoriteButtonCellEvent.favoriteDidTapped
        onFavoriteButtonTap?(event)
        //delegate?.tappedFavoriteButton()
    }
    
    private func setViews(){
        backImage.addSubview(backView)
        [
            backImage,
            favoriteButton,
            categoryLabel,
            articleNameLabel,
        ].forEach { contentView.addSubview($0) }
    }
    
    private func layoutViews(){
        backImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(backImage)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(articleNameLabel.snp.top).offset(-8)
            make.leading.equalTo(backImage.snp.leading).offset(16)
        }
        
        articleNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backImage.snp.bottom).offset(-16)
            make.leading.equalTo(backImage.snp.leading).offset(16)
            make.trailing.equalTo(backImage.snp.trailing).offset(-16)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.width.height.equalTo(24)     
        }
    }
}

//MARK: - Configure Cell UI Public Method
extension ArticleCouruselCell{
    func configCell(categoryLabelText: String?, articleNameText: String?, image: UIImage?, isLiked: Bool){
        categoryLabel.text = categoryLabelText?.uppercased()
        articleNameLabel.text = articleNameText
        let favoriteImage: UIImage? = isLiked ? UIImage(named: "bookmark-selected") : UIImage(named: "bookmark-bordered")
        favoriteButton.setBackgroundImage(favoriteImage, for: .normal)
        if let image = image{
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            backImage.image = image
        } else{
            setUpSpiner() //добавить spineer
            backImage.backgroundColor = .none
        }
    }
}
