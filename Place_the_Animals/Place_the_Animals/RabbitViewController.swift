//
//  RabbitViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit

class RabbitViewController: UIViewController, AnimalGestureHandlerDelegate {
    
    // MARK: - Outlets, Propriedades e Variaveis
    
    @IBOutlet weak var rabbit: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rabbitplace: UIImageView!
    
    var gestureHandler: GestureHandler!
   
    var currentScore: Int = 0 {
        didSet {
            print("RabbitViewController - Current score updated: \(currentScore)")
        }
    }

    // MARK: - Funções de ciclo de vida e métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        checkIfAnimalIsInPlace()
        updateScoreLabel()
    }

    // MARK: - Funções auxiliares

    private func setupGestureHandler() {
        gestureHandler = setupGestureHandler(for: rabbit, with: self)
    }

    private func updateScoreLabel() {
        scoreLabel.text = "\(currentScore)"
        print("RabbitViewController - Score label updated to: \(currentScore)")
    }

    func checkIfAnimalIsInPlace() {
            UIViewController.checkIfAnimalIsInPlace(animalView: rabbit, animalPlace: rabbitplace, currentScore: &currentScore, withPoints: 20, scoreLabel: scoreLabel)
             checkTransitionCondition()
        }

    // Função para alterar para a tela BeardDragonViewController
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
