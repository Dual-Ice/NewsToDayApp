//
//  SpinnersFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 25.03.2024.
//

import UIKit

final class SpinnersFactory{
    static func makeSpinner() -> UIActivityIndicatorView{
        let spinner = UIActivityIndicatorView()
        spinner.color = UIColor(named: ConstColors.purplePrimary)
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        return spinner
    }
}
