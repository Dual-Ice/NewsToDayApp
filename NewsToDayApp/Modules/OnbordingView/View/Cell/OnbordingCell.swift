//
//  File.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//

import UIKit
import SnapKit

class OnbordingCell: UICollectionViewCell {
    static let resuseID = "OnbordingCell"
    
    private let titleLabel = LabelsFactory.makeHeaderLabel()
    private let descriptionLabel = LabelsFactory.makeTextLabel()
    private let imageCart = ImageViewFactory.makeCornerRadiusImage()

    
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
        titleLabel.text = nil
        descriptionLabel.text = nil
        imageCart.image = nil
    }
    
    private func setUpViews(){
        
    }
    
    
    private func setViews(){
        [
            titleLabel,
            descriptionLabel,
            imageCart,
        ].forEach { contentView.addSubview($0) }
    }
    
    private func layoutViews(){
        imageCart.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(32)
            make.trailing.equalTo(contentView.snp.trailing).offset(-32)
             make.top.equalTo(contentView.snp.top)
             make.height.equalTo(336)
         }

         titleLabel.snp.makeConstraints { make in
             make.top.equalTo(imageCart.snp.bottom).offset(82)
             make.centerX.equalTo(contentView.snp.centerX)
        
             make.leading.equalTo(contentView.snp.leading).offset(80)
             make.trailing.equalTo(contentView.snp.trailing).offset(-80)
         }

         descriptionLabel.snp.makeConstraints { make in
             make.top.equalTo(titleLabel.snp.bottom).offset(24)
             make.centerX.equalTo(contentView.snp.centerX)
             //make.height.equalTo(30)
             make.leading.equalTo(contentView.snp.leading).offset(80)
             make.trailing.equalTo(contentView.snp.trailing).offset(-80)
         }
    }
}

//MARK: - Configure Cell UI Public Method
extension OnbordingCell{
    func configCell(titleText: String, descriptionText: String, image: UIImage){
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        imageCart.image = image
    }
}
