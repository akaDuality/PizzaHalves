//
//  PizzaHalfTitleHeader.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 14/11/2018.
//  Copyright © 2018 Dodo Pizza. All rights reserved.
//

import UIKit

class PizzaHalfTitleHeader: UICollectionReusableView {

    var halfOrientation: PizzaHalfOrientation = .left {
        didSet {
            switch halfOrientation {
            case .left:
                titleLabel.textAlignment = .left
                subtitleLabel.textAlignment = .left
            case .right:
                titleLabel.textAlignment = .right
                subtitleLabel.textAlignment = .right
            }
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
}
