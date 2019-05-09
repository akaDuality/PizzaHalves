//
//  PizzaHalfSelectorLayout+Headers.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 02/03/2019.
//  Copyright © 2019 Dodo Pizza. All rights reserved.
//

import UIKit

extension PizzaHalfSelectorLayout {
    
    func headers(for paths: [IndexPath]) -> [UICollectionViewLayoutAttributes] {
        let headers: [UICollectionViewLayoutAttributes] = paths.map {
            layoutAttributesForSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader, at: $0)
            }.compactMap { $0 }
        
        return headers
    }
    
    func updateHeaders(_ headers: [UICollectionViewLayoutAttributes]) {
        for header in headers {
            let scale = self.scale(for: header.indexPath.row)
            
            let alpha =  1 - abs(scale)
            header.alpha = alpha
            
            let translation = 20 * scale
            header.transform = CGAffineTransform(translationX: 0,
                                                 y: translation)
        }
    }
    
    func defaultFrameForHeader(at indexPath: IndexPath) -> CGRect {
        let inset   = max(collectionView!.layoutMargins.left,
                          collectionView!.layoutMargins.right)
        
        let y       = collectionView!.bounds.minY
        let height  = collectionView!.bounds.height
        let width   = collectionView!.bounds.width
        
        let headerWidth = width - inset * 2
        let headerHeight: CGFloat = 60
        let vOffset: CGFloat = 30
        
        let screenY = (height - itemSize.height) / 2 - headerHeight / 2 - vOffset
        
        
        return CGRect(x: inset,
                      y: y + screenY,
                      width: headerWidth,
                      height: headerHeight)
    }
}
