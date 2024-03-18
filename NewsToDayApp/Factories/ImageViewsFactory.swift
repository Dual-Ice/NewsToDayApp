//
//  ImageViewsFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//

import Foundation
import UIKit
protocol ImageViewsFactoryProtocol{
    func makeCornerRadiusImage() -> UIImageView
}

final class ImageViewFactory: ImageViewsFactoryProtocol{
    func makeCornerRadiusImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.configImageView(cornerRadius: 12)
        return imageView
    }
}
