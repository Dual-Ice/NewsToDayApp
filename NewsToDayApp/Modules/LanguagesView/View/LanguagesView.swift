//
//  LanguagesView.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import UIKit

protocol LanguagesViewDelegate: AnyObject {
    func tappedBackButton()
    func languageButtonTapped(value: String?)
}

final class LanguagesView: CustomView {
    
    weak var delegate: LanguagesViewDelegate?
    
    private let title = LabelsFactory.makeHeaderLabel()
    private let backButton = ButtonsFactory.makeButton()
    
    private lazy var languagesButtonsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    } ()
    
    //MARK: - ConfigView public method
    func configView(languages: [String:String], currentLanguageCode: String){
        for (languageCode, languageName) in languages {
            let isCurrentLanguage = currentLanguageCode == languageCode
            let languageButton = CustomButton(
                label: languageName,
                icon: isCurrentLanguage ? UIImage.Icons.checkmark : nil,
                backgroundColor: isCurrentLanguage ? ConstColors.purplePrimary : ConstColors.greyLighter,
                contenColor: isCurrentLanguage ? ConstColors.customWhite : ConstColors.greyDarker
            )
            languageButton.value = languageCode
            
            languageButton.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
            
            languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
                        
            languagesButtonsVStack.addArrangedSubview(languageButton)
        }
    }
    
    override func setViews() {
        setUpViews()
        print(Bundle.main.localizations.filter { $0 != "Base" })
        
        backgroundColor = .white
        [
            title,
            backButton,
            languagesButtonsVStack
        ].forEach { addSubview($0) }
    }
    
    override func layoutViews() {
        
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(title)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }

        languagesButtonsVStack.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("LanguagesViewTitle", comment: "")
        backButton.backgroundColor = .clear
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        backButton.tintColor = UIColor(named: ConstColors.greyPrimary)
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
    
    @objc private func languageButtonTapped(_ sender: CustomButton){
        delegate?.languageButtonTapped(value: sender.value)
    }
}
