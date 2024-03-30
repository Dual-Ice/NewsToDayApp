//
//  ProfileView.swift
//  NewsToDayApp
//
//  Created by Sergey on 17.03.2024.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func signOutButtonTapped()
    func languageButtonTapped()
    func termsAndConditionsButtonTapped()
    func changeProfileImage()
    func changeTheme(_ sender: UISegmentedControl)
}

class ProfileView: CustomView {
    weak var delegate: ProfileViewDelegate?
    
    private let title = LabelsFactory.makeHeaderLabel()
    private let profileName = LabelsFactory.makeArticleHeaderLabel()
    private let profileEmail = LabelsFactory.makeCategoryLabel()
    private let profileImage = ImageViewFactory.makeCornerRadiusImage()
    
    private lazy var changeThemeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ConstColors.greyLighter)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var changeThemeLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("ProfleViewchangeThemeLabel", comment: "")
        label.font = UIFont.TextFont.Screen.button
        label.textColor = UIColor(named: ConstColors.greyDarker)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var themePickerSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: [NSLocalizedString("backgroundForSCLight", comment: ""), NSLocalizedString("backgroundForSCDark", comment: "")])
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: ConstColors.greyDarker)!]
        sc.setTitleTextAttributes(titleTextAttributes, for: .normal)
        sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
        sc.selectedSegmentTintColor = .white
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let languageButton = CustomButton(
        label: NSLocalizedString("ProfleViewLanguageButton", comment: ""),
        value: nil,
        icon: UIImage.Icons.chevronRight ?? UIImage(),
        backgroundColor: ConstColors.greyLighter,
        contenColor: ConstColors.greyDarker
    )
    private let termsAndConditionsButton = CustomButton(
        label: NSLocalizedString("ProfleViewTermsAndConditionsButton", comment: ""),
        value: nil,
        icon: UIImage.Icons.chevronRight ?? UIImage(),
        backgroundColor: ConstColors.greyLighter,
        contenColor: ConstColors.greyDarker
    )
    private let signOutButton = CustomButton(
        label: NSLocalizedString("ProfleViewSignOutButton", comment: ""),
        value: nil,
        icon: UIImage.Icons.signout ?? UIImage(),
        backgroundColor: ConstColors.greyLighter,
        contenColor: ConstColors.greyDarker
    )
    override func setViews() {
        setUpViews()
        self.backgroundColor = UIColor(named: ConstColors.customWhite)
        [
            title,
            profileName,
            profileEmail,
            profileImage,
            languageButton,
            termsAndConditionsButton,
            signOutButton
        ].forEach{ addSubview($0) }
        addSubview(changeThemeView)
        changeThemeView.addSubview(changeThemeLabel)
        changeThemeView.addSubview(themePickerSegmentedControl)
    }
    
    override func layoutViews() {
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.leading.equalToSuperview().offset(16)
        }
        
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(72)
            make.top.equalTo(title.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        
        profileName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).offset(12)
            make.left.equalTo(profileImage.snp.right).offset(24)
            make.trailing.equalToSuperview().offset(-20)
        }
        profileEmail.snp.makeConstraints { make in
            make.top.equalTo(profileName.snp.bottom).offset(5)
            make.left.equalTo(profileImage.snp.right).offset(24)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(56)
        }
        
        changeThemeView.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(56)
        }
        changeThemeLabel.snp.makeConstraints { make in
            make.leading.equalTo(changeThemeView.snp.leading).offset(20)
            make.centerY.equalTo(changeThemeView.snp.centerY)
        }
        
        themePickerSegmentedControl.snp.makeConstraints { make in
            make.trailing.equalTo(changeThemeView.snp.trailing).offset(-20)
            make.centerY.equalTo(changeThemeView.snp.centerY)
            make.leading.equalTo(changeThemeLabel.snp.trailing).offset(20)
        }
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.bottom.equalTo(signOutButton.snp.top).offset(-28)

            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(56)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-28)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(56)
        }
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("ProfleViewTitle", comment: "")
        profileImage.backgroundColor = UIColor(named: ConstColors.greyLighter)
        profileImage.layer.cornerRadius = 36
        profileImage.image = UIImage.Icons.userAvatar
        profileImage.tintColor = UIColor(named: ConstColors.purpleLight)
        makeProfileImageTappable()
        
        profileName.text = ""
        profileName.textColor = UIColor(named: ConstColors.blackPrimary)
        profileName.font = UIFont.TextFont.Profile.profileName
        
        profileEmail.text = ""
        profileEmail.textColor = UIColor(named: ConstColors.greyPrimary)
        profileEmail.font = UIFont.TextFont.Profile.profileEmail
        languageButton.addTarget(nil, action: #selector(languageButtonTapped), for: .touchUpInside)
        termsAndConditionsButton.addTarget(nil, action: #selector(termsAndConditionsButtonTapped), for: .touchUpInside)
        signOutButton.addTarget(nil, action: #selector(signOutButtonTapped), for: .touchUpInside)
        themePickerSegmentedControl.addTarget(nil, action: #selector(appThemeSelected), for: .valueChanged)
    }
    
    func configView(with userData: UserData) {
        profileName.text = userData.username
        profileEmail.text = userData.email
        guard let image = userData.image else { return }
        
        profileImage.image = image
        
    }
    
    
    private func makeProfileImageTappable() {
        if profileImage.gestureRecognizers != nil {
            profileImage.gestureRecognizers?.removeAll()
        }
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(profileImageTapped)
        )
        
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapRecognizer)
    }
    
    func setAppThemeSwitch() {
        let theme = UserDefaults.standard.object(forKey: "theme") as? String
        if theme == "dark" {
            themePickerSegmentedControl.selectedSegmentIndex = 1
        } else {
            themePickerSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    func updateProfileImage(_ image: UIImage) {
        profileImage.image = image
    }
    
    @objc private func signOutButtonTapped(){
        delegate?.signOutButtonTapped()
    }
    
    @objc private func languageButtonTapped(){
        delegate?.languageButtonTapped()
    }
    
    @objc private func termsAndConditionsButtonTapped(){
        delegate?.termsAndConditionsButtonTapped()
    }
    
    
    @objc private func profileImageTapped(_ gesture: UITapGestureRecognizer) {
        delegate?.changeProfileImage()
    }
    
    @objc private func appThemeSelected(_ sender: UISegmentedControl) {
        delegate?.changeTheme(sender)
    }
}
