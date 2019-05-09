//
//  SimpleCellLayout.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 14/11/2018.
//  Copyright © 2018 Dodo Pizza. All rights reserved.
//

import UIKit

class TableLayout: UICollectionViewLayout {
    
    var orientation: PizzaHalfOrientation = .left
    
    var itemSize: CGSize = .zero  {
        didSet {
            invalidateLayout()
        }
    }
    
    private let section = 0
    var cache = TableLayoutCache.zero
    
    override var collectionViewContentSize: CGSize {
        return cache.contentSize
    }
    
    override func prepare() {
        super.prepare()
        
        let numberOfItems = collectionView!.numberOfItems(inSection: section)
            
        cache = TableLayoutCache(itemSize: itemSize,
                                 collectionWidth: collectionView!.bounds.width)
        cache.recalculateDefaultFrames(numberOfItems: numberOfItems)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let indexes = cache.visibleRows(in: rect)
        
        let cells = indexes.map { (row) -> UICollectionViewLayoutAttributes? in
            let path = IndexPath(row: row, section: section)
            let attributes = layoutAttributesForItem(at: path)
            return attributes
        }.compactMap { $0 }
        
        return cells
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = cache.defaultCellFrame(atRow: indexPath.row)
        
        return attributes
    }
}
