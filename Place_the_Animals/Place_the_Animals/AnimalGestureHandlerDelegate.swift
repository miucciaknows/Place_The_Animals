//
//  GestureHandler.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

// AnimalGestureHandler.swift
import UIKit
import Foundation


class AnimalGestureHandler {
    
    weak var viewController: UIViewController?
    weak var animal: UIImageView?
    weak var placeholder: UIImageView?
    weak var scoreLabel: UILabel?
    
    init(viewController: UIViewController, animal: UIImageView, placeholder: UIImageView, scoreLabel: UILabel) {
        self.viewController = viewController
        self.animal = animal
        self.placeholder = placeholder
        self.scoreLabel = scoreLabel
    }
    
    func setupPanGesture(for view: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let draggedView = gesture.view, let animal = animal, let placeholder = placeholder, let scoreLabel = scoreLabel else { return }
        
        let translation = gesture.translation(in: draggedView.superview)
        draggedView.center = CGPoint(x: draggedView.center.x + translation.x,
                                      y: draggedView.center.y + translation.y)
        gesture.setTranslation(.zero, in: draggedView.superview)
        
        if gesture.state == .ended {
            // Verifica se o animal está no lugar correto
            if let viewController = viewController as? AnimalPlacementDelegate {
                viewController.checkIfAnimalIsInPlace(animal: animal, placeholder: placeholder, scoreLabel: scoreLabel)
            }
        }
    }

}
