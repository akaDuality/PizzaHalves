//
//  PizzaHalfSelectorLayout.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 10/10/2018.
//  Copyright © 2018 Dodo Pizza. All rights reserved.
//

import UIKit

final class PizzaHalfSelectorLayout: TableLayout {
    
    // MARK: - Header visiblity
    var headerReferenceSize: CGSize = .zero
    
    // MARK: - Pizza index
    var currentPizzaIndex: CGFloat = 0
    
    var currentPizzaIndexInt: Int {
        return Int(currentPizzaIndex)
    }
    
    private func updateCurrentPizzaIndex() {
        currentPizzaIndex = pizzaIndex(offset: collectionView!.contentOffset)
    }
    
    // MARK: - Private
    private let cellZLevel = 0
    private let headerZLevel = 2
    
    func setupSizeAndInsets(pizzaSize: CGFloat) {
        itemSize = CGSize(width: pizzaSize / 2, height: pizzaSize)
        headerReferenceSize = CGSize(width: pizzaSize / 2, height: 50)
        setupInsets(pizzaSize: pizzaSize)
    }
    
    private func setupInsets(pizzaSize: CGFloat){
        let height = collectionView!.bounds.height
        let inset = (height - pizzaSize) / 2
        collectionView!.contentInset = UIEdgeInsets(top: inset,
                                                    left: 0,
                                                    bottom: inset,
                                                    right: 0)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true // Invalidate on scroll
    }

    // MARK: - Scroll alignment
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let pizzaIndex      = Int(self.pizzaIndex(offset: proposedContentOffset))
        let projectedOffset = contentOffset(for: pizzaIndex)
        
        let sameCell = pizzaIndex == currentPizzaIndexInt
        if sameCell {
            animateBackwardScroll(to: pizzaIndex)
            return collectionView!.contentOffset // Stop scroll, we've animated manually
        }
        
        return projectedOffset
    }
    
    /// A bit of magic. Without that, high velocity moves cells backward very fast.
    /// We slow down the animation
    private func animateBackwardScroll(to pizzaIndex: Int) {
        let path = IndexPath(row: pizzaIndex, section: 0)
        
        collectionView?.scrollToItem(at: path,
                                          at: .centeredVertically, animated: true)
        
        // More magic here. Fix double-step animation.
        // You can't do it smoothly without that. Run loop, you know, ykhhh.
        DispatchQueue.main.async {
            self.collectionView?.scrollToItem(at: path,
                                              at: .centeredVertically, animated: true)
        }
    }
    
    // MARK: - Customize attributes
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let elements = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        updateCurrentPizzaIndex()
        
        let cells = elements.filter { $0.representedElementCategory == .cell }
        updateCells(cells)
        
        let visiblePaths = cells.map { $0.indexPath }
        let headers = self.headers(for: visiblePaths)
        updateHeaders(headers)
        
        let visibleHeaders = headers.filter { $0.alpha > 0 }
        
        return cells + visibleHeaders
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String,
                                                       at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            
        let attributes = UICollectionViewLayoutAttributes(
            forSupplementaryViewOfKind: elementKind, with: indexPath)
        
        attributes.frame = defaultFrameForHeader(at: indexPath)
        attributes.zIndex = headerZLevel
        
        return attributes
    }

    static let criticalOffsetFromCenter: CGFloat = 200
    static private let scaleFactor: CGFloat = 0.6
    
    var spaceBetweenHalves: CGFloat = 4
}

// MARK: - Layout
extension PizzaHalfSelectorLayout {
    
    private func updateCells(_ cells: [UICollectionViewLayoutAttributes]) {
        for cell in cells {
            let normScale = scale(for: cell.indexPath.row)
            let scale = 1 - PizzaHalfSelectorLayout.scaleFactor * abs(normScale)
            
            cell.alpha       = scale
            cell.frame       = centerAlignedFrame(for: cell, scale: scale)
            cell.transform   = CGAffineTransform(scaleX: scale, y: scale)
            cell.zIndex      = cellZLevel
        }
    }
}
