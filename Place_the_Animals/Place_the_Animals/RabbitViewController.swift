//
//  RabbitViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit

class RabbitViewController: UIViewController, AnimalGestureHandlerDelegate {

    
    
    @IBOutlet weak var rabbit: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rabbitplace: UIImageView!
    
    var currentScore: Int = 0
       
       
       var gestureHandler: GestureHandler!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupGestureHandler()
           updateScoreLabel()
       }
       
       func setupGestureHandler() {
           gestureHandler = GestureHandler(view: rabbit)
           gestureHandler.delegate = self
       }
       
       func updateScoreLabel() {
           scoreLabel.text = "\(currentScore)"
       }
       
       func checkIfAnimalIsInPlace() {
           let animalCenter = CGPoint(x: rabbit.frame.midX, y: rabbit.frame.midY)
           if rabbitplace.frame.contains(animalCenter) {
               rabbitplace.isHidden = true
               currentScore += 20
               updateScoreLabel()
               print("Pontuação atualizada para \(currentScore)")
               checkTransitionCondition()
           }
       }
       
    func checkTransitionCondition() {
        if currentScore == 30 {
            transitionToBeardDragonViewController()
        }
    }
    
    
       @objc func transitionToBeardDragonViewController() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let beardDragonViewController = storyboard.instantiateViewController(withIdentifier: "BeardDragonViewController") as? BeardDragonViewController {
               print("BeardDragonViewController instanciado com sucesso.")
               beardDragonViewController.currentScore = currentScore
               beardDragonViewController.modalPresentationStyle = .overFullScreen
               present(beardDragonViewController, animated: true, completion: nil)
           } else {
               print("Erro ao instanciar BeardDragonViewController")
           }
       }
   }
