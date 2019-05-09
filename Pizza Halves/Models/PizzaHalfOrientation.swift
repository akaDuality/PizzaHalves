//
//  PizzaHalfOrientation.swift
//  Pizza Halves
//
//  Created by Mikhail Rubanov on 14/04/2019.
//  Copyright © 2019 DodoPizza. All rights reserved.
//

enum PizzaHalfOrientation {
    case left
    case right
}

extension PizzaHalfOrientation {
    func opposite() -> PizzaHalfOrientation {
        switch self {
        case .left:  return .right
        case .right: return .left
        }
    }
}
