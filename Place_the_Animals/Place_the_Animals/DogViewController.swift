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
             scoreLabel.text = ": \(score)"
             if score == 50 {
                 print("Pontuação atingiu 50 pontos. Iniciando transição para RabbitViewController.")
                 transitionToRabbitViewController()
             }
         }
     }
     
     var gestureHandler: GestureHandler!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupGestureHandler()
         
         
     }
     
     private func setupGestureHandler() {
         gestureHandler = GestureHandler(view: dog)
         gestureHandler.delegate = self
     }
     
     func checkIfAnimalIsInPlace() {
         let animalCenter = CGPoint(x: dog.frame.midX, y: dog.frame.midY)
         if dogplace.frame.contains(animalCenter) {
             dogplace.isHidden = true
             score += 50
             print("Pontuação atualizada para \(score)")
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
