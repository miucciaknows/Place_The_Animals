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
   
    var currentScore: Int = 0 {
        didSet {
            print("RabbitViewController - Current score updated: \(currentScore)")
        }
    }
    
    var gestureHandler: GestureHandler!

    // Funções de ciclo de vida e métodos

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        checkIfAnimalIsInPlace() // Mover para após a chamada de updateScoreLabel()
        updateScoreLabel()
    }

    // Funções auxiliares

    private func setupGestureHandler() {
        gestureHandler = setupGestureHandler(for: rabbit, with: self)
    }

    private func updateScoreLabel() {
        scoreLabel.text = "\(currentScore)"
        print("RabbitViewController - Score label updated to: \(currentScore)")
    }

    internal func checkIfAnimalIsInPlace() {
        let animalCenter = CGPoint(x: rabbit.frame.midX, y: rabbit.frame.midY)
        if rabbitplace.frame.contains(animalCenter) {
            rabbitplace.isHidden = true
            currentScore += 20
            updateScoreLabel()
            print("RabbitViewController - Pontuação atualizada para \(currentScore)")
            checkTransitionCondition()
        }
    }

    private func checkTransitionCondition() {
        if currentScore == 30 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let beardDragonViewController = storyboard.instantiateViewController(withIdentifier: "BeardDragonViewController") as? BeardDragonViewController {
                beardDragonViewController.currentScore = currentScore
                beardDragonViewController.modalPresentationStyle = .fullScreen
                present(beardDragonViewController, animated: true, completion: nil)
            }
        }
    }
}
