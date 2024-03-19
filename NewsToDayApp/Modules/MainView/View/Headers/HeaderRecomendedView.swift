//
//  HeaderRecomendedView.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import UIKit

class HeaderRecomendedView: UICollectionReusableView {
    static let resuseID = "HeaderRecomendedView"
    private let headerLabel = LabelsFactory.makeHeaderLabel()
    private let buttonLabel = LabelsFactory.makeTextLabel()
    private let buttonSeeAll = ButtonsFactory.makeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(){
        backgroundColor = .white
        headerLabel.font = UIFont.TextFont.Main.recommendedLabel
        buttonLabel.font = UIFont.TextFont.Main.seeAllLabel
        buttonLabel.text = "See all"
        buttonSeeAll.backgroundColor = .clear
        buttonSeeAll.setTitle(buttonLabel.text, for: .normal)
    }
    
    private func setViews(){
        [
            buttonSeeAll,
            headerLabel,
        ].forEach { addSubview($0) }
        
    }
    
    private func layoutViews(){
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        buttonSeeAll.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(46)
            make.height.equalTo(24)
        }
        
    }
    
    func configureHeader(sectionTitle: String){
        headerLabel.text = sectionTitle
    }
}
