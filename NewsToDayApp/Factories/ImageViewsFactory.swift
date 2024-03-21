//
//  ImageViewsFactory.swift
//  NewsToDayApp
//
//  Created by Polina on 18.03.2024.
//


import UIKit

final class ImageViewFactory{
    static func makeCornerRadiusImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.configImageView(cornerRadius: 12)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
