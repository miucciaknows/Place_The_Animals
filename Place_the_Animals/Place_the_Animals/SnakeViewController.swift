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
    
    var score = 400 {
        didSet {
            if score == 700 {
                print("Pontuação atingiu 200 pontos. Iniciando transição para BirdViewController.")
                transitionToBirdViewController()
            }
        }
    }
    
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
        scoreLabel.text = ": \(score)"
    }
    
    func checkIfAnimalIsInPlace() {
        let animalCenter = CGPoint(x: snake.frame.midX, y: snake.frame.midY)
        if snakeplace.frame.contains(animalCenter) {
            snakeplace.isHidden = true
            score += 300
            updateScoreLabel()
            print("Pontuação atualizada para \(score)")
        }
    }
    
    

    
    
    @objc func transitionToBirdViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let birdViewController = storyboard.instantiateViewController(withIdentifier: "BirdViewController") as? BirdViewController {
            print("BirdViewController instanciado com sucesso.")
            birdViewController.currentScore = score
            birdViewController.modalPresentationStyle = .overFullScreen
            present(birdViewController, animated: true, completion: nil)
        } else {
            print("Erro ao instanciar BirdViewController")
        }
    }
    
    
}
