//
//  SnakeViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation
import UIKit


class SnakeViewController: UIViewController, AnimalGestureHandlerDelegate {
    
    
    // MARK: - Outlets, Propriedades e Variaveis
 
    @IBOutlet weak var snake: UIImageView!
    @IBOutlet weak var snakeplace: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentScore: Int = 0
    var gestureHandler: GestureHandler!
    
    // MARK: - Funções de ciclo de vida e métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        updateScoreLabel()
     
    }

    // MARK: - Funções auxiliares
    
    private func setupGestureHandler() {
        gestureHandler = setupGestureHandler(for: snake, with: self)
    }
 
    
 private func updateScoreLabel() {
     scoreLabel.text = "\(currentScore)"
 }
    
    func checkIfAnimalIsInPlace() {
           UIViewController.checkIfAnimalIsInPlace(animalView: snake, animalPlace: snakeplace, currentScore: &currentScore, withPoints: 40, scoreLabel: scoreLabel)
            checkTransitionCondition()
       }

    // Função para alterar para a tela BirdViewController
    private func checkTransitionCondition() {
        if currentScore == 100 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let birdViewController = storyboard.instantiateViewController(withIdentifier: "BirdViewController") as? BirdViewController {
                birdViewController.currentScore = currentScore
                birdViewController.modalPresentationStyle = .fullScreen
                present(birdViewController, animated: true, completion: nil)
            }
        }
    }

}
