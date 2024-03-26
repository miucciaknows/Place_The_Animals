//
//  BeardDragonViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation
import UIKit



class BeardDragonViewController: UIViewController, AnimalGestureHandlerDelegate {
    var currentScore: Int = 0
    var gestureHandler: GestureHandler!
    
    @IBOutlet weak var beardDragon: UIImageView!
    
    @IBOutlet weak var beardDragonPlace: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        updateScoreLabel()
    }
    
    
    func setupGestureHandler() {
        gestureHandler = GestureHandler(view: beardDragon)
        gestureHandler.delegate = self
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(currentScore)"
    }
    
    func checkIfAnimalIsInPlace() {
        let beardDragonFrame = beardDragon.convert(beardDragon.bounds, to: view)
        let beardDragonplaceFrame = beardDragonPlace.frame

        let intersectionRect = beardDragonFrame.intersection(beardDragonFrame )
        let overlapArea = intersectionRect.width * intersectionRect.height
        let shadowArea = beardDragonFrame.width * beardDragonFrame.height
        let overlapPercentage = overlapArea / shadowArea

        if overlapPercentage >= 0.95 {
            beardDragonPlace.isHidden = true
            currentScore += 100
            updateScoreLabel()
            print("Pontuação atualizada para \(currentScore)")
        }
    }
    
    
    
}
