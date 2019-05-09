//
//  PizzaHalfSelectorLayout+Scale.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 02/03/2019.
//  Copyright © 2019 Dodo Pizza. All rights reserved.
//

import UIKit

extension PizzaHalfSelectorLayout {
    
    func scale(for row: Int) -> CGFloat {
        let frame = cache.defaultCellFrame(atRow: row)
        let scale = self.scale(for: frame)
        return scale.normalized
    }
    
    func scale(for frame: CGRect) -> CGFloat {
        let criticalOffset = PizzaHalfSelectorLayout.criticalOffsetFromCenter // 200 pt
        let centerOffset = offsetFromScreenCenter(frame)
        let relativeOffset = centerOffset / criticalOffset
        
        return relativeOffset
    }
    
    func offsetFromScreenCenter(_ frame: CGRect) -> CGFloat {
        return frame.midY - collectionView!.screenCenterYOffset() 
    }
}

extension CGFloat {
    var normalized: CGFloat {
        return CGFloat.minimum(1, CGFloat.maximum(-1, self))
    }
}
