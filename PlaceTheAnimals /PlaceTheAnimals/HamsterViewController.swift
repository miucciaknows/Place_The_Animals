//
//  HamsterViewController.swift
//  pickone
//
//  Created by Miuccia  on 27/03/21.
//

import Foundation
import UIKit

class HamsterViewController: UIViewController, UIDragInteractionDelegate {
    
    
    @IBOutlet weak var hamster: UIImageView!
    
    @IBOutlet weak var hamsterplace: UIImageView!
    
    
    var counter = 0
    var score: Int = 20
    var highScore: Int = 0
 
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = hamster.image else { return [] }
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
        
        hamster.image = UIImage(named: "hamster.png")
        hamster.contentMode = .scaleAspectFit
        hamster.isUserInteractionEnabled = true
        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        hamster.addInteraction(dragInteraction)
        
        hamsterplace.contentMode = .scaleAspectFit
        hamsterplace.isUserInteractionEnabled = true
        let configuration = UIPasteConfiguration(forAccepting: UIImage.self)
        hamsterplace.pasteConfiguration = configuration
        
        
        let stackView = UIStackView(arrangedSubviews: [hamster, hamsterplace])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.frame = view.bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //Criando um novo recorde
        //Creating a new high score
        if score > highScore {
            highScore = score
            highScoreLabel.text = "Recorde: \(score)"
            
            UserDefaults.standard.set(highScore, forKey: "Recorde: ")
        }
    }
    
    override func paste(itemProviders: [NSItemProvider]) {
        _ = itemProviders.first?.loadObject(ofClass: UIImage.self, completionHandler: { (image: NSItemProviderReading?, error: Error?) in
            DispatchQueue.main.async { [self] in
                self.hamsterplace.image = image as? UIImage
                increaseScore()
                nextLevel()
            }
        })
        
    }
    
    //Função score
    //Score function
    @objc func increaseScore(){
        score += 10
        scoreLabel.text = "\(score)"
    }
    
    @objc func nextLevel() {
        let alert = UIAlertController(title: "Você passou para o próximo nivel", message: "Gostaria de prosseguir? ", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Não", style: UIAlertAction.Style.cancel, handler: nil)
        let restartButton = UIAlertAction(title: "Sim", style: UIAlertAction.Style.default) { (UIAlertAction) in
      
            
        }
        alert.addAction(okButton)
        alert.addAction(restartButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    














