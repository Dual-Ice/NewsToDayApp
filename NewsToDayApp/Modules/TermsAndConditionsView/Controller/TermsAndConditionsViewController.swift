//
//  TermsAndConditionsViewController.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import UIKit

class TermsAndConditionsViewController: CustomViewController<TermsAndConditionsView> {
    
    var presenter: TermsAndConditionsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
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

//MARK: - TermsAndConditionsViewDelegate
extension TermsAndConditionsViewController: TermsAndConditionsViewDelegate {
    func tappedBackButton() {
        presenter?.dismissTermsAndConditionsVC()
    }
}

//MARK: - TermsAndConditionsPresenterViewProtocol
extension TermsAndConditionsViewController: TermsAndConditionsPresenterViewProtocol {
    
}

