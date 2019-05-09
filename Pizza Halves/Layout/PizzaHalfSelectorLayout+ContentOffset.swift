//
//  PizzaHalfSelectorLayout+contentOffset.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 02/03/2019.
//  Copyright © 2019 Dodo Pizza. All rights reserved.
//

import UIKit

extension PizzaHalfSelectorLayout {
    
    func contentOffset(for pizzaIndex: Int) -> CGPoint {
        let cellHeight  = itemSize.height
        let screenHalf  = collectionView!.bounds.height / 2
        
        let midY        = cellHeight * CGFloat(pizzaIndex) + cellHeight / 2
        let newY        = midY - screenHalf
        
        return CGPoint(x: 0, y: newY)
    }
    
    func pizzaIndex(offset: CGPoint) -> CGFloat {
        let cellHeight      = itemSize.height
        
        let proposedCenterY = collectionView!.screenCenterYOffset(for: offset)
        let pizzaIndex      = proposedCenterY / cellHeight
        
        return pizzaIndex
    }
}
