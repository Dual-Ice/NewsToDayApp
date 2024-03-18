//
//  ProfileFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import UIKit
enum LabelsProfileType{
    case headerLabel
    case profileNameLabel
    case profileEmailLabel
    case collectionlabel
}

protocol ProfileFactoryProtocol{
    func makeLabel(type: LabelsProfileType) -> UILabel
    func makeImageView() -> UIImageView
}

final class ProfileFactory: ProfileFactoryProtocol{
    func makeLabel(type: LabelsProfileType) -> UILabel {
        switch type{
        case .headerLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Screen.label, lines: 1, alignment: .center, color: ConstColors.blackPrimary)
            return label
        case .profileNameLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Profile.profileName, lines: 1, alignment: .left, color: ConstColors.blackPrimary)
            return label
        case .profileEmailLabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Profile.profileEmail, lines: 1, alignment: .left, color: ConstColors.greyPrimary)
            return label
        case .collectionlabel:
            let label = UILabel()
            label.configLabel(font: UIFont.TextFont.Profile.profileName, lines: 1, alignment: .left, color: ConstColors.greyDarker)
            return label
        }
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.configBackImageView(backColor: ConstColors.purpleLight, borderWidth: 0, borderColor: ConstColors.customWhite)
        return imageView
    }
}
