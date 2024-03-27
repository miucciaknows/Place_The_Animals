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
       
    private func setupGestureHandler() {
        gestureHandler = setupGestureHandler(for: beardDragon, with: self)
    }

       
    private func updateScoreLabel() {
        scoreLabel.text = "\(currentScore)"
    }
       
    
    func checkIfAnimalIsInPlace() {
           UIViewController.checkIfAnimalIsInPlace(animalView: beardDragon, animalPlace: beardDragonPlace, currentScore: &currentScore, withPoints: 30, scoreLabel: scoreLabel)
            checkTransitionCondition()
       }
  
    private func checkTransitionCondition() {
        if currentScore == 60 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let snakeViewController = storyboard.instantiateViewController(withIdentifier: "SnakeViewController") as? SnakeViewController {
                snakeViewController.currentScore = currentScore
                snakeViewController.modalPresentationStyle = .fullScreen
                present(snakeViewController, animated: true, completion: nil)
            }
        }
    }
   }
