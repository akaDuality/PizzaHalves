//
//  PizzaHalfSelectorLayout+Alignment.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 02/03/2019.
//  Copyright © 2019 Dodo Pizza. All rights reserved.
//

import UIKit

extension PizzaHalfSelectorLayout {
    
    func centerAlignedFrame(for element: UICollectionViewLayoutAttributes, scale: CGFloat) -> CGRect {
        
        let hOffset = horizontalOffset(for: element, scale: scale)
        let vOffset = verticalOffset  (for: element, scale: scale)
        
        switch orientation {
        case .left: // Align to right
            return element.frame.offsetBy(dx: +hOffset - spaceBetweenHalves / 2,
                                          dy: vOffset)
        case .right: // Align to left
            return element.frame.offsetBy(dx: -hOffset + spaceBetweenHalves / 2,
                                          dy: vOffset)
        }
    }
    
    private func horizontalOffset(for element: UICollectionViewLayoutAttributes, scale: CGFloat) -> CGFloat {
        let collectionWidth = collectionView!.bounds.width
        let scaledElementWidth = element.frame.width * scale
        let hOffset = (collectionWidth - scaledElementWidth) / 2
        
        return hOffset
    }
    
    private func verticalOffset(for element: UICollectionViewLayoutAttributes, scale: CGFloat) -> CGFloat {
        let offsetFromCenter    = offsetFromScreenCenter(element.frame)
        let vOffset: CGFloat    = PizzaHalfSelectorLayout.verticalOffset(
            offsetFromCenter: offsetFromCenter,
            scale: scale)
        
        return vOffset
    }
    
    static func verticalOffset(offsetFromCenter: CGFloat,
                               scale: CGFloat) -> CGFloat {
        return -offsetFromCenter / 4 * scale
    }
}
