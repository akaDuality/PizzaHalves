//
//  PizzaHalfCollectionController.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 10/10/2018.
//  Copyright © 2018 Dodo Pizza. All rights reserved.
//

import UIKit

class PizzaHalfCollectionController: UICollectionViewController {
    var side: PizzaHalfOrientation = .left {
        didSet {
            pizzaHalfLayout.orientation = side
        }
    }

    var halves: [PizzaHalvesViewModel] = []
    
    var mainPizzaSize: CGFloat {
        let isBigDevice = UIScreen.main.bounds.width > 320
        if isBigDevice {
            return 300
        } else {
            return 230
        }
    }
    
    // MARK: - Public
    func scroll(to pizzaIndex: Int, animated: Bool = true) {
        let offset = pizzaHalfLayout.contentOffset(for: pizzaIndex)
        collectionView!.setContentOffset(offset, animated: animated)
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? PizzaHalfSelectorLayout {
            layout.setupSizeAndInsets(pizzaSize: mainPizzaSize)
        }
        
        collectionView!.decelerationRate = .fast
        collectionView!.delegate = self
        collectionView!.registerCellFromNib(ofType: PizzaHalfCell.self)
        collectionView!.registerSupplementaryFromNib(
            ofType: PizzaHalfTitleHeader.self,
            kind: UICollectionView.elementKindSectionHeader)
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return halves.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let halfModel = halves[indexPath.row]
        
        let cell = collectionView.dequeueCellOf(type: PizzaHalfCell.self, for: indexPath)
            cell.halfOrientation = side
            cell.pizzaHalf = halfModel
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let halfModel = halves[indexPath.row]
        
        let header = collectionView.dequeueSupplementaryOf(
            type: PizzaHalfTitleHeader.self,
            for: indexPath,
            kind: UICollectionView.elementKindSectionHeader)
        
        header.halfOrientation = side
        header.title    = halfModel.name
        
        return header
    }
}

extension PizzaHalfCollectionController {
    private var pizzaHalfLayout: PizzaHalfSelectorLayout {
        return collectionView!.collectionViewLayout as! PizzaHalfSelectorLayout
    }
}


