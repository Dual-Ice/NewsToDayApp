//
//  LanguagesViewController.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import UIKit

class LanguagesViewController: CustomViewController<LanguagesView> {
    
    var presenter: LanguagesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        customView.configView(languages: availableLanguagesWithNames(), currentLanguageCode: "ru")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setDelegates(){
        customView.delegate = self
    }
    
    
    func availableLanguagesWithNames() -> [String:String] {
        let availableLanguages = Bundle.main.localizations.filter { $0 != "Base" }
        var languagesWithNames: [String:String] = [:]
        
        for langCode in availableLanguages {
            let langName = Locale(identifier: langCode).localizedString(forLanguageCode: langCode) ?? "Unknown"
            languagesWithNames[langCode] = langName.capitalized
        }
        
        return languagesWithNames
    }

}

//MARK: - LanguagesViewDelegate
extension LanguagesViewController: LanguagesViewDelegate {
    func languageButtonTapped(value: String?) {
        print("Language button is tapped - \(value)")
    }
    
    func tappedBackButton() {
        presenter?.dismissLanguagesVC()
    }
    
}

//MARK: - LanguagesPresenterViewProtocol
extension LanguagesViewController: LanguagesPresenterViewProtocol {
    
}

