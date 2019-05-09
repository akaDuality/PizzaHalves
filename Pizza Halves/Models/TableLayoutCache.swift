//
//  LayoutCache.swift
//  Pizza Halves
//
//  Created by Mikhail Rubanov on 14/04/2019.
//  Copyright © 2019 DodoPizza. All rights reserved.
//

import UIKit

class TableLayoutCache {
    
    // MARK: - Calculation
    func recalculateDefaultFrames(numberOfItems: Int) {
        defaultFrames = (0..<numberOfItems).map {
            defaultCellFrame(atRow: $0)
        }
    }
    
    func defaultCellFrame(atRow row: Int) -> CGRect {
        let y = itemSize.height * CGFloat(row)
        let defaultFrame = CGRect(x: 0, y: y,
                                  width: collectionWidth,
                                  height: itemSize.height)
        return defaultFrame
    }
    
    
    // MARK: - Access
    func visibleRows(in frame: CGRect) -> [Int] {
        return defaultFrames
            .enumerated() // Index to frame relation
            .filter { $0.element.intersects(frame)} // Filter by frame
            .map { $0.offset } // Return indexes
    }
    
    var contentSize: CGSize {
        return CGSize(width: collectionWidth,
                      height: defaultFrames.last?.maxY ?? 0)
    }
    
    static var zero: TableLayoutCache {
        return TableLayoutCache(itemSize: .zero, collectionWidth: 0)
    }
    
    init(itemSize: CGSize, collectionWidth: CGFloat) {
        self.itemSize = itemSize
        self.collectionWidth = collectionWidth
    }
    
    private let itemSize: CGSize
    private let collectionWidth: CGFloat
    private var defaultFrames = [CGRect]()
}
