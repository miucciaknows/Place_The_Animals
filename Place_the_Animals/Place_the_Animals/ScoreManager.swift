//
//  ScoreManager.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import Foundation


class ScoreManager {
    static let shared = ScoreManager()
    
    private(set) var score = 0
    
    private init() {}
    
    func increaseScore(_ points: Int) {
        score += points
    }
    
    func resetScore() {
        score = 0
    }
}
