//
//  BirdViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation
import UIKit

class BirdViewController: UIViewController, AnimalGestureHandlerDelegate {
    
    var currentScore: Int = 0
    var gestureHandler: GestureHandler!
    
    @IBOutlet weak var bird: UIImageView!
    @IBOutlet weak var birdplace: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureHandler()
        updateScoreLabel()
   
    }
    
    private func setupGestureHandler() {
        gestureHandler = setupGestureHandler(for: bird, with: self)
    }
 
    
 private func updateScoreLabel() {
     scoreLabel.text = "\(currentScore)"
 }
    
    func checkIfAnimalIsInPlace() {
           UIViewController.checkIfAnimalIsInPlace(animalView: bird, animalPlace: birdplace, currentScore: &currentScore, withPoints: 50, scoreLabel: scoreLabel)
           
       }



    
 


}
