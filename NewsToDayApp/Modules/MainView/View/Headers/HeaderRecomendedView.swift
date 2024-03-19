//
//  HeaderRecomendedView.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//


import UIKit
protocol HeaderRecomendedViewDelegate: AnyObject {
    func tappedSeeAllButton()
}

class HeaderRecomendedView: UICollectionReusableView {
    static let resuseID = "HeaderRecomendedView"
    weak var delegate: HeaderRecomendedViewDelegate?
    private let headerLabel = LabelsFactory.makeHeaderLabel()
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
        buttonSeeAll.backgroundColor = .none
        buttonSeeAll.setTitle("See all", for: .normal)
        buttonSeeAll.setTitleColor(UIColor(named: ConstColors.greyPrimary), for: .normal)
        buttonSeeAll.titleLabel?.font = UIFont.TextFont.Main.seeAllLabel
        buttonSeeAll.addTarget(nil, action: #selector(buttonSeeAllTapped), for: .touchUpInside)
    }
    
    @objc private func buttonSeeAllTapped(){
        delegate?.tappedSeeAllButton()
    }
    
    private func setViews(){
        [
            buttonSeeAll,
            headerLabel,
        ].forEach { addSubview($0) }
    }
    
    private func layoutViews(){
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        buttonSeeAll.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(46)
            make.height.equalTo(24)
        }
    }
    
    func configureHeader(sectionTitle: String){
        headerLabel.text = sectionTitle
    }
}
