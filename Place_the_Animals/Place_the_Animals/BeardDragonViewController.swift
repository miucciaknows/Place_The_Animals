//
//  BeardDragonViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation
import UIKit



class BeardDragonViewController: UIViewController, AnimalGestureHandlerDelegate {
    
    var currentScore: Int = 0
    var gestureHandler: GestureHandler!
    
    @IBOutlet weak var beardDragon: UIImageView!
    
    @IBOutlet weak var beardDragonPlace: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score = 200 {
        didSet {
            if score == 400 {
                print("Pontuação atingiu 400 pontos. Iniciando transição para BeardDragonViewController.")
                transitionToSnakeViewController()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        updateScoreLabel()
    }
    
    func setupGestureHandler() {
        gestureHandler = GestureHandler(view: beardDragon)
        gestureHandler.delegate = self
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "\(currentScore)"
    }
    
    func checkIfAnimalIsInPlace() {
        let beardDragonFrame = beardDragon.convert(beardDragon.bounds, to: view)
        let beardDragonPlaceFrame = beardDragonPlace.frame

        let intersectionRect = beardDragonFrame.intersection(beardDragonPlaceFrame)
        let overlapArea = intersectionRect.width * intersectionRect.height
        let shadowArea = beardDragonPlaceFrame.width * beardDragonPlaceFrame.height
        let overlapPercentage = overlapArea / shadowArea

        if overlapPercentage >= 0.95 {
            beardDragonPlace.isHidden = true
            currentScore += 200
            score += 200
            updateScoreLabel()
            print("Pontuação atualizada para \(currentScore)")
        }
    }
    
    
    @objc func transitionToSnakeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let snakeViewController = storyboard.instantiateViewController(withIdentifier: "SnakeViewController") as? SnakeViewController{
            print("SnakeViewControllerinstanciado com sucesso.")
            snakeViewController.currentScore = score
            snakeViewController.modalPresentationStyle = .overFullScreen
            present(snakeViewController , animated: true, completion: nil)
        } else {
            print("Erro ao instanciar SnakeViewController")
        }
    }
}
