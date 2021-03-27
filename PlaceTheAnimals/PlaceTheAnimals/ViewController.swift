//
//  ViewController.swift
//  PlaceTheAnimals
// Portuguese Version
//  Created by Miuccia  on 26/03/21.
//

import UIKit

class ViewController: UIViewController, UIDragInteractionDelegate {
    
    @IBOutlet weak var dog: UIImageView!
    @IBOutlet weak var dogplace: UIImageView!

    var counter = 0
    var score: Int = 0
    var highScore: Int = 0
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = dog.image else { return [] }
        let item = UIDragItem(itemProvider: NSItemProvider(object: image))
        
        return [item]
        
    }

    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        //HighScore
        let storeHighScore = UserDefaults.standard.object(forKey: "HighScore")
    
        if storeHighScore == nil {
            highScore = 0
            
            highScoreLabel.text = "Recorde: \(highScore)"
        }

        //Onde define um novo recorde.
        //creating a new high score
        if let newScore = storeHighScore as? Int {
            highScore = Int(newScore)
            highScoreLabel.text = "Recorde: \(highScore)"
        }
        
        //O texto "Pontos" que aparece no jogo. não sei porque usei double, talvez porque queria dar 0.5 em algumas ocasiões e 1 em outras, talez isso mude.
        //Score text
        //scoreLabel.text="Pontos: \(score)"
        self.scoreLabel.text = String (format: "%.f", score)
            
        dog.image = UIImage(named: "dog.png")
        dog.contentMode = .scaleAspectFit
        dog.isUserInteractionEnabled = true
        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        dog.addInteraction(dragInteraction)

        dogplace.contentMode = .scaleAspectFit
        dogplace.isUserInteractionEnabled = true
        let configuration = UIPasteConfiguration(forAccepting: UIImage.self)
        dogplace.pasteConfiguration = configuration

        
        let stackView = UIStackView(arrangedSubviews: [dog, dogplace])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.frame = view.bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //Criando um novo recorde
        //Creating a new high score
        if score > highScore{
            highScore = score
            highScoreLabel.text = "Recorde: \(score)"
            
            UserDefaults.standard.set(highScore, forKey: "Recorde: ")
        }
        
       
        
}
    //Função score
    //Score function

    @objc func increaseScore(){
        score += 10
        scoreLabel.text="\(score)"
    }
    
    
    
    override func paste(itemProviders: [NSItemProvider]) {
            _ = itemProviders.first?.loadObject(ofClass: UIImage.self, completionHandler: { (image: NSItemProviderReading?, error: Error?) in
                DispatchQueue.main.async { [self] in
                    self.dogplace.image = image as? UIImage
                    increaseScore()
                   
                    
                    
                }
            })
        }
    
    
}
