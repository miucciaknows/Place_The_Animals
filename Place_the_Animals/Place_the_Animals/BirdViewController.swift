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
    
    // Funções de ciclo de vida e métodos
        override func viewDidLoad() {
            super.viewDidLoad()
            confetti.isHidden = true
            setupGestureHandler()
            updateScoreLabel()
        }
        
        // Função auxiliar para configurar o Gesture Handler
        private func setupGestureHandler() {
            gestureHandler = setupGestureHandler(for: bird, with: self)
        }
        
        // Função auxiliar para atualizar o rótulo de pontuação
        private func updateScoreLabel() {
            scoreLabel.text = "\(currentScore)"
        }
        

        
        // Função para verificar se o animal está no lugar correto
        func checkIfAnimalIsInPlace() {
            UIViewController.checkIfAnimalIsInPlace(animalView: bird, animalPlace: birdplace, currentScore: &currentScore, withPoints: 50, scoreLabel: scoreLabel)
            checkTransitionCondition()
        }
        
    // Função para alterar para a principal se o usuário obter 150 pontos
        private func checkTransitionCondition() {
            if currentScore == 150 {
                // Exibi imagem do confetti caso o usuário ter 150 pontos
                confetti.isHidden = false
                // Altera a tela, aguardando 2 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: true, completion: nil)
                    }
                }
            }
        }
        
        func animalMoved() {
            // Verificando se o animal está no lugar esperado sempre que ele for movido
            checkIfAnimalIsInPlace()
        }
    }
