//
//  AnimalPresenter.swift
//  PlaceTheAnimals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit



class AnimalPresenter {
    private weak var view: AnimalView?
    private var score = 0
    private var highScore = 0
    private var animalImage: UIImage?
    private var animalPlaceImage: UIImage?
    
    init(view: AnimalView, animalImage: UIImage, animalPlaceImage: UIImage) {
        self.view = view
        self.animalImage = animalImage
        self.animalPlaceImage = animalPlaceImage
    }
    
    func viewDidLoad() {
        view?.updateScoreLabel(with: score)
        view?.updateHighScoreLabel(with: highScore)
        view?.setAnimalImage(animalImage)
        view?.setAnimalPlaceImage(animalPlaceImage)
    }
    
    // Implement other shared logic
    
    func increaseScore() {
        score += 10
        view?.updateScoreLabel(with: score)
    }
    
    func nextLevel() {
        // Implement next level logic
    }
}
