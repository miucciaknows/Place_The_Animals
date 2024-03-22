//
//  AnimalView.swift
//  PlaceTheAnimals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import Foundation
import UIKit

protocol AnimalView: AnyObject {
    func updateScoreLabel(with score: Int)
    func updateHighScoreLabel(with highScore: Int)
    func setAnimalImage(_ image: UIImage?)
    func setAnimalPlaceImage(_ image: UIImage?)
}
