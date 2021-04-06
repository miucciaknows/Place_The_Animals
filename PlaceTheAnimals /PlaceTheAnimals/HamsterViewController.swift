//
//  HamsterViewController.swift
//  pickone
//
//  Created by Miuccia  on 27/03/21.
//

import Foundation
import UIKit

class HamsterViewController: UIViewController, UIDragInteractionDelegate {
    
    //Drag Interaction Function
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = hamster.image else { return [] }
        let item = UIDragItem(itemProvider: NSItemProvider(object: image))
        return [item]
        
    }
    
    
    //Definition of Variables
    
    var score: Int = 0
    public var highScore: Int = 0
   
    //Variables from UIImageView, the ones from storyboard.
    
    @IBOutlet weak var hamster: UIImageView!
    
    @IBOutlet weak var hamsterplace: UIImageView!

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
  
    //This Function calls UIPanGestureRecognizer with this i can take the image from storyboard and put it anywhere. I'm calling this function from storyboard, there's a UIPanGestureRecognizer defined there.
    
    @IBAction func handlePan(_ gesture: UIPanGestureRecognizer) {
    
    let translation = gesture.translation(in: view)

      guard let gestureView = gesture.view else {
        return
      }

      gestureView.center = CGPoint(
        x: gestureView.center.x + translation.x,
        y: gestureView.center.y + translation.y
      )

      gesture.setTranslation(.zero, in: view)
        guard gesture.state == .ended else {
          return
        }
        
    }
    
    //This Function UIPinchGestureRecognizer with this i can take the image from storyboard and zoom in/zoom out. I'm calling this function from storyboard, there's a UIPinchGestureRecognizer defined there.
    
    @IBAction func handlePinch(_ gesture: UIPinchGestureRecognizer) {
    guard let gestureView = gesture.view else {
          return
       }
    
      gestureView.transform = gestureView.transform.scaledBy(
      x: gesture.scale,
      y: gesture.scale
   )
     
        gesture.scale = 1
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //HighScore
        let storeHighScore = UserDefaults.standard.object(forKey: "HighScore")
        
        if storeHighScore == nil {
            highScore = 0

            highScoreLabel.text = "Recorde: \(highScore)"
        }
        
        //Creating a new high score
        if let newScore = storeHighScore as? Int {
            highScore = Int(newScore)
            highScoreLabel.text = "Recorde: \(highScore)"
        }
        
        //Score text
        //scoreLabel.text="Pontos: \(score)"
        self.scoreLabel.text = String (format: "%.f", score)
     

        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear
        
        
        //Drag and drop enabled interaction with the images from UIImageView.
        //User enable interaction.
        
        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        hamster.addInteraction(dragInteraction)
        hamster.backgroundColor = UIColor.clear
        
        hamsterplace.contentMode = .scaleAspectFit
        hamsterplace.isUserInteractionEnabled = true
        let configuration = UIPasteConfiguration(forAccepting: UIImage.self)
        hamsterplace.pasteConfiguration = configuration
        
        //Creating a new high score
        if score > highScore{
            highScore = score
            highScoreLabel.text = "Recorde: \(score)"
            
            UserDefaults.standard.set(highScore, forKey: "Recorde: ")
        }
    }
    
    //This function allowed me to drop the object to the shadow itself. it's kind of copy and paste thing.
    
    override func paste(itemProviders: [NSItemProvider]) {
        _ = itemProviders.first?.loadObject(ofClass: UIImage.self, completionHandler: { (image: NSItemProviderReading?, error: Error?) in
            DispatchQueue.main.async { [self] in
                self.hamsterplace.image = image as? UIImage
                //Earning points when drop the object to the shadow.
                increaseScore()
                //Calling next level function
                nextLevel()
                hideHamster()
            
            }
        })
    }
    
    
    //Function to hide dog's shadow when you drop it.
    
    @objc func hideHamster(){
             hamster.isHidden=true
        
         }
    
    //Score function
   
    @objc func increaseScore(){
        score += 10
        scoreLabel.text = "\(score)"
    }
    
    //Next level function
    
    @objc func nextLevel() {
        let alert = UIAlertController(title: "Você passou para o próximo nivel", message: "Gostaria de prosseguir? ", preferredStyle: UIAlertController.Style.alert)
        let noButton = UIAlertAction (title: "Não", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //Sleep function, 1 sec delay to go to the cancel screen.
            sleep(1)
            //Opening the next view controller//next level, in this case it's the cancel view controller.
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CancelViewController") as! CancelViewController
            nextViewController.highScore = self.score
            nextViewController.modalPresentationStyle = .overFullScreen
            self.present(nextViewController, animated: true, completion: nil)
            
        }
        //Next level stuff
        let restartButton = UIAlertAction(title: "Sim", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //Sleep function, 1 sec delay to go to the next level.
            sleep(1)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BirdViewController") as! BirdViewController
            //Using the score from this level to keep counting to the next.
            nextViewController.score = self.score
            nextViewController.highScore = self.score
            nextViewController.modalPresentationStyle = .overFullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        //Button stuff
        alert.addAction(noButton)
        alert.addAction(restartButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}

//Class extension to make multiple gesture happen.
extension HamsterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
      _ gestureRecognizer: UIGestureRecognizer,
      shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
      return true
    }
}


