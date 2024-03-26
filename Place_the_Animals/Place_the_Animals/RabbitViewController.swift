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
       
       var score = 50 {
           didSet {
               if score == 200 {
                   print("Pontuação atingiu 200 pontos. Iniciando transição para BeardDragonViewController.")
                   transitionToBeardDragonViewController()
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
           gestureHandler = GestureHandler(view: rabbit)
           gestureHandler.delegate = self
       }
       
       func updateScoreLabel() {
           scoreLabel.text = "\(score)"
       }
       
       func checkIfAnimalIsInPlace() {
           let animalCenter = CGPoint(x: rabbit.frame.midX, y: rabbit.frame.midY)
           if rabbitplace.frame.contains(animalCenter) {
               rabbitplace.isHidden = true
               score += 150
               updateScoreLabel()
               print("Pontuação atualizada para \(score)")
           }
       }
       
       @objc func transitionToBeardDragonViewController() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let beardDragonViewController = storyboard.instantiateViewController(withIdentifier: "BeardDragonViewController") as? BeardDragonViewController {
               print("BeardDragonViewController instanciado com sucesso.")
               beardDragonViewController.currentScore = score
               beardDragonViewController.modalPresentationStyle = .overFullScreen
               present(beardDragonViewController, animated: true, completion: nil)
           } else {
               print("Erro ao instanciar BeardDragonViewController")
           }
       }
   }
