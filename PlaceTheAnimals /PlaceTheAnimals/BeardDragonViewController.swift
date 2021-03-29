//
//  BeardDragonViewController.swift
//  pickone
//
//  Created by Miuccia  on 28/03/21.
//

import Foundation
import UIKit


class BeardDragonViewController: UIViewController, UIDragInteractionDelegate {
    
    @IBOutlet weak var bearddragon: UIImageView!
    @IBOutlet weak var bearddragonplace: UIImageView!
    
    var score: Int = 50
    var highScore: Int = 0
          
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = bearddragon.image else { return [] }
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
        
        bearddragon.image = UIImage(named: "bearddragon.png")
        bearddragon.contentMode = .scaleAspectFit
        bearddragon.isUserInteractionEnabled = true
        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        bearddragon.addInteraction(dragInteraction)
        
        bearddragonplace.contentMode = .scaleAspectFit
        bearddragonplace.isUserInteractionEnabled = true
        let configuration = UIPasteConfiguration(forAccepting: UIImage.self)
        bearddragonplace.pasteConfiguration = configuration
        
        
        let stackView = UIStackView(arrangedSubviews: [bearddragon, bearddragonplace])
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
                    self.bearddragonplace.image = image as? UIImage
                    increaseScore()
                    nextLevel()
                    hideBeardDragon()
                }
            })
            
        }
        
        //Function to hide dog when you drop it.
        //Função para esconder o cachorro quando você usa o drop.
        @objc func hideBeardDragon(){
            bearddragon.isHidden=true
            
             }
        
        //Função score
        //Score function
        @objc func increaseScore(){
            score += 10
            scoreLabel.text = "\(score)"
        }
        
        @objc func nextLevel() {
            let alert = UIAlertController(title: "Você passou por todos niveis", message: "****** ", preferredStyle: UIAlertController.Style.alert)
            let restartButton = UIAlertAction(title: "E agora...", style: UIAlertAction.Style.default) { (UIAlertAction) in
                sleep(2)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FinalViewController") as! FinalViewController
                nextViewController.highScore = self.score
                nextViewController.modalPresentationStyle = .overFullScreen
                self.present(nextViewController, animated: true, completion: nil)
               
               
              
                
            }

            alert.addAction(restartButton)
            self.present(alert, animated: true, completion: nil)
          

    }

    

}
