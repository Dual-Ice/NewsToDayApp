//
//  ProfileView.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func handleSignOutButtonTap()
}

class ProfileView: CustomView {
    
    weak var delegate: ProfileViewDelegate?
    
    private lazy var usernameLabel = LabelsFactory.makeTextLabel()
    
    private lazy var signOutButton: UIButton = {
        let button = ButtonsFactory.makeButton()
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    override func setViews() {
        
        self.backgroundColor = .green
        addSubview(usernameLabel)
        addSubview(signOutButton)
    }
    
    override func layoutViews() {
        usernameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        
        signOutButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(16)
            $0.height.equalTo(56)
        }
    }
    
    func configure(with user: FirestoreUser) {
        usernameLabel.text = user.username
    }
    
    @objc private func signOut() {
        delegate?.handleSignOutButtonTap()
    }
}
