//
//  AnimalPlacementLogic.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit

protocol AnimalPlacementDelegate: AnyObject {
    func checkIfAnimalIsInPlace(animal: UIImageView, placeholder: UIImageView, scoreLabel: UILabel) -> Bool
}

extension AnimalPlacementDelegate where Self: UIViewController {
    func checkIfAnimalIsInPlace(animal: UIImageView, placeholder: UIImageView, scoreLabel: UILabel) -> Bool {
        let animalFrame = animal.convert(animal.bounds, to: view)
        let placeholderFrame = placeholder.frame
        
        if animalFrame.intersects(placeholderFrame) {
            placeholder.isHidden = true
            scoreLabel.text = "Pontos: 50"
            return true
        } else {
            return false
        }
    }
}
