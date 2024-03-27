//
//  SnakeViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation
import UIKit


class SnakeViewController: UIViewController, AnimalGestureHandlerDelegate{
    

    
    @IBOutlet weak var snake: UIImageView!
    
    @IBOutlet weak var snakeplace: UIImageView!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentScore: Int = 0
    
    
    var gestureHandler: GestureHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        updateScoreLabel()
    }
    
    func setupGestureHandler() {
        gestureHandler = GestureHandler(view: snake)
        gestureHandler.delegate = self
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(currentScore)"
    }
    
    func checkIfAnimalIsInPlace() {
        let animalCenter = CGPoint(x: snake.frame.midX, y: snake.frame.midY)
        if snakeplace.frame.contains(animalCenter) {
            snakeplace.isHidden = true
            currentScore += 40
            updateScoreLabel()
            print("Pontuação atualizada para \(currentScore)")
            checkTransitionCondition()
        }
    }
    
    

    func checkTransitionCondition() {
        if currentScore == 100 {
            transitionToBirdViewController()
        }
    }
    
    @objc func transitionToBirdViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let birdViewController = storyboard.instantiateViewController(withIdentifier: "BirdViewController") as? BirdViewController {
            print("BirdViewController instanciado com sucesso.")
            birdViewController.currentScore = currentScore
            birdViewController.modalPresentationStyle = .overFullScreen
            present(birdViewController, animated: true, completion: nil)
        } else {
            print("Erro ao instanciar BirdViewController")
        }
    }
    
    
}
