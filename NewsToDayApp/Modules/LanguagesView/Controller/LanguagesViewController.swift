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
        customView.configView(currentLanguageCode: LanguagesService.getCurrentLanguageCode())

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setDelegates(){
        customView.delegate = self
    }
}

//MARK: - LanguagesViewDelegate
extension LanguagesViewController: LanguagesViewDelegate {
    func languageButtonTapped(value: String?) {
        LanguagesService.setLanguage(code: value ?? "")
        customView.configView(currentLanguageCode: LanguagesService.getCurrentLanguageCode())
    }
    
    func tappedBackButton() {
        presenter?.dismissLanguagesVC()
    }
    
}

//MARK: - LanguagesPresenterViewProtocol
extension LanguagesViewController: LanguagesPresenterViewProtocol {
}

