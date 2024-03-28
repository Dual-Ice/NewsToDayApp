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
            .init(image: "first", title: "First to know", description: "All news in one place, be the first to know last news"),
            .init(image: "second", title: "It's important", description: "Always be up to date with the latest events"),
            .init(image: "third", title: "You are ready", description: "Receive new information"),
       ]
    }
}
