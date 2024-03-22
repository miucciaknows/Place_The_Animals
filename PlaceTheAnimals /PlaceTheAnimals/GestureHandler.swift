//
//  GestureHandler.swift
//  PlaceTheAnimals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit

protocol GestureHandlerDelegate: AnyObject {
    func handlePan(_ gesture: UIPanGestureRecognizer)
    func handlePinch(_ gesture: UIPinchGestureRecognizer)
}

extension GestureHandlerDelegate where Self: UIViewController {
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else { return }
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
        guard gesture.state == .ended else { return }
        // Additional logic after pan gesture ended
    }

    func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        gestureView.transform = gestureView.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
        // Additional logic after pinch gesture
    }
}
