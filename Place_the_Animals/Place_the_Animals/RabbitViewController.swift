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
          scoreLabel.text = "Score: \(currentScore)"
      }
      
      func checkIfAnimalIsInPlace() {
          let rabbitFrame = rabbit.convert(rabbit.bounds, to: view)
          let rabbitplaceFrame = rabbitplace.frame

          let intersectionRect = rabbitFrame.intersection(rabbitplaceFrame)
          let overlapArea = intersectionRect.width * intersectionRect.height
          let shadowArea = rabbitplaceFrame.width * rabbitplaceFrame.height
          let overlapPercentage = overlapArea / shadowArea

          if overlapPercentage >= 0.95 {
              rabbitplace.isHidden = true
              currentScore += 100
              updateScoreLabel()
              print("Pontuação atualizada para \(currentScore)")
          }
      }
    
    @objc func transitionToBeardDragonViewController() {
        // Transição para o RabbitViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let beardDragonViewController = storyboard.instantiateViewController(withIdentifier: "BeardDragonViewController") as? BeardDragonViewController {
            print("BeardDragonViewControllerinstanciado com sucesso.")
            beardDragonViewController.currentScore = self.score
            beardDragonViewController.modalPresentationStyle = .overFullScreen
            present(beardDragonViewController, animated: true, completion: nil)
        } else {
            print("Erro ao instanciar BeardDragonViewController")
        }
    }
  }
