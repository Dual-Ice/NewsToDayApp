//
//  OnbordingModel.swift
//  NewsToDayApp
//
//  Created by Polina on 28.03.2024.
//

import Foundation

struct OnbordingModel{
    let image: String
    let title: String
    let description: String
}

extension OnbordingModel{
    static func  getOnbordingModel() -> [OnbordingModel]{
        [
            .init(image: "city1", title: NSLocalizedString("OnbordingFirstTitle", comment: ""), description: NSLocalizedString("OnbordingFirstDescription", comment: "")),
            .init(image: "city2", title: NSLocalizedString("OnbordingSecondTitle", comment: ""), description: NSLocalizedString("OnbordingSecondDescription", comment: "")),
            .init(image: "city3", title: NSLocalizedString("OnbordingThirdTitle", comment: ""), description: NSLocalizedString("OnbordingThirdDescription", comment: "")),
       ]
    }
}
