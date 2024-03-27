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
    
    var score = 0 {
         didSet {
                 transitionToRabbitViewController()
             }
         }
     
     
     var gestureHandler: GestureHandler!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupGestureHandler()
         updateScoreLabel()
     }
     
     private func setupGestureHandler() {
         gestureHandler = GestureHandler(view: dog)
         gestureHandler.delegate = self
     }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(score)"
    }
    
    
     func checkIfAnimalIsInPlace() {
         let animalCenter = CGPoint(x: dog.frame.midX, y: dog.frame.midY)
         if dogplace.frame.contains(animalCenter) {
             dogplace.isHidden = true
             score += 10
             updateScoreLabel()
             print("Pontuação atualizada para \(score)")
         }
     }
    

    func checkTransitionCondition() {
        if score >= 10 {
            transitionToRabbitViewController()
        }
    }

     @objc func transitionToRabbitViewController() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let rabbitViewController = storyboard.instantiateViewController(withIdentifier: "RabbitViewController") as? RabbitViewController {
             print("RabbitViewController instanciado com sucesso.")
             rabbitViewController.currentScore = score
             rabbitViewController.modalPresentationStyle = .overFullScreen
             present(rabbitViewController, animated: true, completion: nil)
         } else {
             print("Erro ao instanciar RabbitViewController")
         }
     }
 }
