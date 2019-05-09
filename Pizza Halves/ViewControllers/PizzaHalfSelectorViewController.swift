//
//  PizzaHalfSelectorViewController.swift
//  DodoPizza
//
//  Created by Mikhail Rubanov on 10/10/2018.
//  Copyright © 2018 Dodo Pizza. All rights reserved.
//

import UIKit

class PizzaHalfSelectorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHalves([PizzaHalvesViewModel(name: "Гавайская"),
                   PizzaHalvesViewModel(name: "Супермясная"),
                   PizzaHalvesViewModel(name: "Пепперони"),
                   PizzaHalvesViewModel(name: "Маргарита"),
            ])
    }
    
    
    /// Only setter because the order is different
    func setHalves(_ halves: [PizzaHalvesViewModel]) {
        leftPicker? .halves = halves
        rightPicker?.halves = halves
    }
    
    // MARK: - Scrolling
    func scrollToZeroPosition(animated: Bool) {
        if let leftPicker = leftPicker, leftPicker.halves.count > 0 {
            leftPicker.scroll(to: 0, animated: animated)
        }
        
        if let rightPicker = rightPicker, rightPicker.halves.count > 0 {
            rightPicker.scroll(to: 0, animated: animated)
        }
    }
    
    // MARK: Embedded controllers
    
    private var leftPicker: PizzaHalfCollectionController?
    private var rightPicker: PizzaHalfCollectionController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "left":
            leftPicker = segue.destination as? PizzaHalfCollectionController
            leftPicker!.side = .left
            
        case "right":
            rightPicker = segue.destination as? PizzaHalfCollectionController
            rightPicker!.side = .right
            
        default: break
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
