//
//  BirdViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation
import UIKit

class BirdViewController: UIViewController, AnimalGestureHandlerDelegate {
    
    
    
    @IBOutlet weak var bird: UIImageView!
    
    @IBOutlet weak var birdplace: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentScore: Int = 0
    
    var score = 700
    
    var gestureHandler: GestureHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        updateScoreLabel()
    }
    
    func setupGestureHandler() {
        gestureHandler = GestureHandler(view: bird)
        gestureHandler.delegate = self
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    func checkIfAnimalIsInPlace() {
        let animalCenter = CGPoint(x: bird.frame.midX, y: bird.frame.midY)
        if birdplace.frame.contains(animalCenter) {
            birdplace.isHidden = true
            score += 500
            updateScoreLabel()
            print("Pontuação atualizada para \(score)")
        }
    }
    
    
}
