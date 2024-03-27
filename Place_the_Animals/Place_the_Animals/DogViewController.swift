//
//  DogViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit


class DogViewController: UIViewController, AnimalGestureHandlerDelegate {
    
    // Outlets
    // Label para exibir o score
    @IBOutlet weak var scoreLabel: UILabel!
    // Imagem do cachorro
    @IBOutlet weak var dog: UIImageView!
    // Sombra onde o cachorro deve ser colocado
    @IBOutlet weak var dogplace: UIImageView!
    
    // Propriedades
    // Handler para os gestos na imagem do cachorro
    var gestureHandler: GestureHandler!
    
    // Variável para rastrear o score atual
    var currentScore: Int = 0 {
         didSet {
             print("DogViewController - Current score updated: \(currentScore)")
         }
     }
    // MARK: - Funções de ciclo de vida e métodos

     override func viewDidLoad() {
         super.viewDidLoad()
         // Configura o Gesture Handler
         setupGestureHandler()
         // Atualiza o label de score
         updateScoreLabel()
         // Verifica se o animal está no lugar CORRETO
         checkIfAnimalIsInPlace()
     }
    // MARK: - Funções auxiliares
   
    // Função para configurar o Gesture Handler para a imagem do cachorro.
     private func setupGestureHandler() {
         // Criando o Gesture Handler
         gestureHandler = setupGestureHandler(for: dog, with: self)
         // Defindo o delegate como esta classe
         gestureHandler.delegate = self
     }
    
    // Função para atualizar o texto do score label com o valor atual do score.
     private func updateScoreLabel() {
         // Atualizando o texto do label com o score
         updateScoreLabel(scoreLabel, with: currentScore)
         print("DogViewController - Score label updated to: \(currentScore)")
     }
    // Função para verificar se o animal está no lugar certo.
   func checkIfAnimalIsInPlace() {
           UIViewController.checkIfAnimalIsInPlace(animalView: dog, animalPlace: dogplace, currentScore: &currentScore, withPoints: 10, scoreLabel: scoreLabel)
            checkTransitionCondition()
       }

    // Função para alterar para a tela RabbitViewController.
    private func checkTransitionCondition() {
        if currentScore == 10 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let rabbitViewController = storyboard.instantiateViewController(withIdentifier: "RabbitViewController") as? RabbitViewController {
                rabbitViewController.currentScore = currentScore
                rabbitViewController.modalPresentationStyle = .fullScreen
                present(rabbitViewController, animated: true, completion: nil)
            }
        }
    }
 }
