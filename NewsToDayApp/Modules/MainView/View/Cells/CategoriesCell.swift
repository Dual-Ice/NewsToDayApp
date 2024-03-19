//
//  CategoriesCell.swift
//  NewsToDayApp
//
//  Created by Polina on 19.03.2024.
//

import UIKit
import SnapKit

class CategoriesCell: UICollectionViewCell {
    static let resuseID = "CategoriesCell"
    
    private let categoryLabel = LabelsFactory.makeCategoryTagLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
