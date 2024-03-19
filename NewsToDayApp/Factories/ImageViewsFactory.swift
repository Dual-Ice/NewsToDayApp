//
//  ImageViewsFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//


import UIKit

final class ImageViewFactory: ImageViewsFactoryProtocol{
    static func makeCornerRadiusImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.configImageView(cornerRadius: 12)
        return imageView
    }
}
