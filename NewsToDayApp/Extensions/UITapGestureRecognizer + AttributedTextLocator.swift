//
//  UITapGestureRecognizer + AttributedTextLocator.swift
//  NewsToDayApp
//
//  Created by Vasilii Pronin on 25.03.2024.
//

import UIKit

extension UITapGestureRecognizer {
    
    func didTapAttributedTextIn(label: UILabel, inRange range: NSRange) -> Bool {
        guard let attributedText = label.attributedText,
              let labelFont = label.font else { return false }
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        attributedString.addAttributes(
            [NSAttributedString.Key.font: labelFont],
            range: NSRange(location: 0, length: attributedText.length)
        )
        
        let labelSize = label.bounds.size
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attributedString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineFragmentPadding = 0
        textContainer.size = labelSize
        
        let tapLocationInLabel = self.location(in: label)
        let textBounds = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBounds.size.width) * 0.5 - textBounds.origin.x,
            y: (labelSize.height - textBounds.size.height) * 0.5 - textBounds.origin.y
        )
        let tapLocationInTextContainer = CGPoint(
            x: tapLocationInLabel.x - textContainerOffset.x,
            y: tapLocationInLabel.y - textContainerOffset.y
        )
        let characterIndex = layoutManager.characterIndex(
            for: tapLocationInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        
        return NSLocationInRange(characterIndex, range)
    }
}
