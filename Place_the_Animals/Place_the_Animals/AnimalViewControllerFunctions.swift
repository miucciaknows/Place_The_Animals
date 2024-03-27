import Foundation
import UIKit

extension UIViewController {
    
    func setupGestureHandler(for view: UIView, with delegate: AnimalGestureHandlerDelegate) -> GestureHandler {
        let gestureHandler = GestureHandler(view: view)
        gestureHandler.delegate = delegate
        return gestureHandler
    }
    
    func updateScoreLabel(_ scoreLabel: UILabel, with score: Int) {
        scoreLabel.text = "\(score)"
    }
    
    static func checkIfAnimalIsInPlace(animalView: UIImageView, animalPlace: UIImageView, currentScore: inout Int, withPoints points: Int, scoreLabel: UILabel) {
        let animalCenter = CGPoint(x: animalView.frame.midX, y: animalView.frame.midY)
        if animalPlace.frame.contains(animalCenter) {
            animalPlace.isHidden = true
            currentScore += points
            scoreLabel.text = "\(currentScore)"
            print("Pontuação atualizada para \(currentScore)")
        }
    }
    
    
    func checkTransitionCondition(currentScore: Int, targetScore: Int, transitionHandler: () -> Void) {
        if currentScore >= targetScore {
            transitionHandler()
        }
    }
    
    
    
    
}
