//
//  UICollectionView+Runtime.swift
//  DodoPizza
//
//  Created by Aleksei Unshchikov on 17.07.2018.
//  Copyright © 2018 Dodo Pizza. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /**
     Load nib with cell by name and register it in the tableView by reuseId that also equal to class'es name
     */
    func registerCellFromNib<CellType>(ofType: CellType.Type)
        where CellType: UICollectionViewCell {
        let classString = String(describing: CellType.self)
        let nib = UINib(nibName: classString, bundle: nil)
        
        register(nib, forCellWithReuseIdentifier: classString)
    }
    
    /**
     Deque cell by reuseId that is equal to class'es name
     */
    func dequeueCellOf<CellType>(type: CellType.Type, for indexPath: IndexPath) -> CellType
        where CellType: UICollectionViewCell {
        let cellId = String(describing: type.self)
        return dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CellType
    }
    
    
    // MARK: - Supplementary
    func registerSupplementaryFromNib<CellType>(ofType: CellType.Type, kind: String)
        where CellType: UICollectionReusableView {
            let classString = String(describing: CellType.self)
            let nib = UINib(nibName: classString, bundle: nil)
            
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: classString)
    }
    
    func dequeueSupplementaryOf<CellType>(type: CellType.Type, for indexPath: IndexPath, kind: String) -> CellType
        where CellType: UICollectionReusableView {
            let cellId = String(describing: type.self)
            let supplementary = dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: cellId,
                                                                      for: indexPath)
            return supplementary as! CellType
    }
}
