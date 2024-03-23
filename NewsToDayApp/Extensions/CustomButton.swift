//
//  CustomButton.swift
//  NewsToDayApp
//
//  Created by  Maksim Stogniy on 22.03.2024.
//

import UIKit

class CustomButton: UIButton {
    private let buttonLabel = LabelsFactory.makeButtonLabel()

    private let buttonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.configImageView(cornerRadius: 0)
        return imageView
    }()
    var value: String?


    // MARK: Init
    init(label: String, icon: UIImage?, backgroundColor: String, contenColor: String) {
        self.buttonLabel.text = label
        self.buttonLabel.textColor = UIColor(named: contenColor)
        if icon != nil {
            self.buttonIcon.image = icon
            self.buttonIcon.tintColor = UIColor(named: contenColor)
        }
        
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: backgroundColor)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
        setViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        [buttonLabel, buttonIcon].forEach {
            addSubview($0)
        }
    }

    private func layoutViews() {
        buttonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
        }

        buttonIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}


