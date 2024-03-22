//
//  DogViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit


class DogViewController: UIViewController, AnimalPlacementDelegate  {
    
    var animalView: AnimalView!
    var gestureHandler: AnimalGestureHandler!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var dog: UIImageView!
    
 
    @IBOutlet weak var dogplace: UIImageView!
    
    
    var score = 0 {
           didSet {
               scoreLabel.text = "Pontos: \(score)"
           }
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupAnimalView()
           
           gestureHandler = AnimalGestureHandler(viewController: self, animal: dog, placeholder: dogplace, scoreLabel: scoreLabel)
           gestureHandler.setupPanGesture(for: dog)
       }
       
       private func setupAnimalView() {
           animalView = AnimalView(frame: dogplace.bounds)
           dogplace.addSubview(animalView)
       }
       
       func checkIfAnimalIsInPlace(animal: UIImageView, placeholder: UIImageView, scoreLabel: UILabel) {
           let dogFrame = dog.convert(dog.bounds, to: view)
           let dogplaceFrame = dogplace.frame
           
           if dogFrame.intersects(dogplaceFrame) {
               dogplace.isHidden = true
               score = 50
           }
       }
   }
