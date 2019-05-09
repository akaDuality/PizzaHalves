//
//  UIScrollView+CenterOffset.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 02/03/2019.
//  Copyright © 2019 Dodo Pizza. All rights reserved.
//

import UIKit

extension UIScrollView {
    func screenCenterYOffset(for offset: CGPoint? = nil) -> CGFloat {
        let offsetY = offset?.y ?? contentOffset.y
        let contentOffsetY = offsetY + bounds.height / 2
        
        return contentOffsetY
    }
}
