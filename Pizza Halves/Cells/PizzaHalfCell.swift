//
//  PizzaHalfCell.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 10/10/2018.
//  Copyright © 2018 Dodo Pizza. All rights reserved.
//

import UIKit

class PizzaHalfCell: UICollectionViewCell {

    var pizzaHalf: PizzaHalvesViewModel?
    
    var halfOrientation: PizzaHalfOrientation = .left {
        didSet {
            imageView?.contentMode = halfOrientation == .left ? .topRight : .topLeft
            imageView.image = image(for: halfOrientation)
            setNeedsLayout()
        }
    }
    
    private func image(for side: PizzaHalfOrientation) -> UIImage {
        switch side {
        case .left: return UIImage(named: "left")!
        case .right: return UIImage(named: "right")!
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
}
