//
//  BirdViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation
import UIKit

class BirdViewController: UIViewController, AnimalGestureHandlerDelegate {

    // MARK: - Outlets, Propriedades e Variaveis
    @IBOutlet weak var bird: UIImageView!
    @IBOutlet weak var birdplace: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var confetti: UIImageView!
    
    
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
        gestureHandler = setupGestureHandler(for: bird, with: self)
    }
 
    
 private func updateScoreLabel() {
     scoreLabel.text = "\(currentScore)"
     // Verificando se atingiu 150 pontos
        if currentScore == 150 {
            // Exibe a imagem
            confetti.isHidden = false
        } else {
            confetti.isHidden = true
        }
 }
    
    func checkIfAnimalIsInPlace() {
           UIViewController.checkIfAnimalIsInPlace(animalView: bird, animalPlace: birdplace, currentScore: &currentScore, withPoints: 50, scoreLabel: scoreLabel)
        checkTransitionCondition()
           
       }
    
    private func checkTransitionCondition() {
        if currentScore == 150 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                viewController.modalPresentationStyle = .fullScreen
                present(viewController, animated: true, completion: nil)
            }
        }
    }


}
