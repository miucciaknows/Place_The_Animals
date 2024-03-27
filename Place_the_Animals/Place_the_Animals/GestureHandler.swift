//
//  GestureHandler.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//


import UIKit
import Foundation

protocol AnimalGestureHandlerDelegate: AnyObject {
    func checkIfAnimalIsInPlace()
}

class GestureHandler: NSObject {
    weak var delegate: AnimalGestureHandlerDelegate?
    
    init(view: UIView) {
        super.init()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let draggedView = gesture.view else { return }
        
        let translation = gesture.translation(in: draggedView.superview)
        draggedView.center = CGPoint(x: draggedView.center.x + translation.x, y: draggedView.center.y + translation.y)
        gesture.setTranslation(.zero, in: draggedView.superview)
        
        if gesture.state == .ended {
            delegate?.checkIfAnimalIsInPlace()
        }
    }
}
