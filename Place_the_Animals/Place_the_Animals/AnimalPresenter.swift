//
//  AnimalPresenter.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import Foundation

protocol AnimalPresenterDelegate: AnyObject {
    func updateScore(_ score: Int)
    func showNextLevelPrompt()
    func showGameOver()
}

class AnimalPresenter {
    
    weak var delegate: AnimalPresenterDelegate?
    
    var score: Int = 0 {
        didSet {
            delegate?.updateScore(score)
        }
    }
    

    func handleAnimalDrop() {
        score += 10
        if score % 50 == 0 {
            delegate?.showNextLevelPrompt()
        }
    }
    
    func endGame() {
        delegate?.showGameOver()
    }
}
