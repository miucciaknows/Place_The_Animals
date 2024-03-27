//
//  DogViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit


class DogViewController: UIViewController, AnimalGestureHandlerDelegate {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dog: UIImageView!
    @IBOutlet weak var dogplace: UIImageView!
    

    var gestureHandler: GestureHandler!
    
    var currentScore: Int = 0 {
         didSet {
             print("DogViewController - Current score updated: \(currentScore)")
         }
     }
     
     // Funções de ciclo de vida e métodos
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupGestureHandler()
         updateScoreLabel()
         checkIfAnimalIsInPlace() // Mover para após a chamada de updateScoreLabel()
     }
     
     // Funções auxiliares
     
     private func setupGestureHandler() {
         gestureHandler = setupGestureHandler(for: dog, with: self)
     }
     
     private func updateScoreLabel() {
         updateScoreLabel(scoreLabel, with: currentScore)
         print("DogViewController - Score label updated to: \(currentScore)")
     }
     
    internal func checkIfAnimalIsInPlace() {
         let animalCenter = CGPoint(x: dog.frame.midX, y: dog.frame.midY)
         if dogplace.frame.contains(animalCenter) {
             dogplace.isHidden = true
             currentScore += 10
             updateScoreLabel()
             print("DogViewController - Pontuação atualizada para \(currentScore)")
             checkTransitionCondition()
         }
     }
    private func checkTransitionCondition() {
        if currentScore == 10 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let rabbitViewController = storyboard.instantiateViewController(withIdentifier: "RabbitViewController") as? RabbitViewController {
                rabbitViewController.currentScore = currentScore
                rabbitViewController.modalPresentationStyle = .fullScreen // Definir como fullscreen
                present(rabbitViewController, animated: true, completion: nil)
            }
        }
    }
 }
