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
    
    private let enLanguageButton = CustomButton(
        label: Languages.en.label,
        value: Languages.en.code,
        icon: nil,
        backgroundColor: ConstColors.greyLighter,
        contenColor: ConstColors.greyDarker
    )
    private let ruLanguageButton = CustomButton(
        label: Languages.ru.label,
        value: Languages.ru.code,
        icon: nil,
        backgroundColor: ConstColors.greyLighter,
        contenColor: ConstColors.greyDarker
    )
    
    private lazy var languagesButtonsVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    } ()
    
    private var currentLanguage: String?
    
    //MARK: - ConfigView public method
    func configView(currentLanguageCode: String) {
        currentLanguage = currentLanguageCode
        for view in languagesButtonsVStack.subviews {
            if let button = view as? CustomButton {
                if button.value == currentLanguageCode {
                    button.changeState(icon: UIImage.Icons.checkmark, backgroundColor: ConstColors.purplePrimary, contenColor: ConstColors.customWhite
                    )
                }
            }
        }
    }
    
    override func setViews() {
        backgroundColor = .white
        
        [
            enLanguageButton,
            ruLanguageButton
        ].forEach { languagesButtonsVStack.addArrangedSubview($0) }
        
        [
            title,
            backButton,
            languagesButtonsVStack
        ].forEach { addSubview($0) }
        setUpViews()
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
        
        for view in languagesButtonsVStack.subviews {
            if let languageButton = view as? CustomButton {
                languageButton.snp.makeConstraints { make in
                    make.height.equalTo(56)
                }
            }
        }
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("LanguagesViewTitle", comment: "")
        backButton.backgroundColor = .clear
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        backButton.tintColor = UIColor(named: ConstColors.greyPrimary)
        
        for view in languagesButtonsVStack.subviews {
            if let languageButton = view as? CustomButton {
                languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
            }
        }
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
    
    @objc private func languageButtonTapped(_ sender: CustomButton){
        if currentLanguage == sender.value {
            return
        }
        
        sender.changeState(
            icon: nil,
            backgroundColor: ConstColors.greyLighter,
            contenColor: ConstColors.greyDarker
        )
        delegate?.languageButtonTapped(value: sender.value)
    }
}
