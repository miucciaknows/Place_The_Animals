import UIKit

class HamstersViewController: UIViewController, UIDragInteractionDelegate, GestureHandlerDelegate {
    
    // Variables and IBOutlets...
    
    // Definition of Variables
    var score: Int = 0
    public var highScore: Int = 0
   
    // Variables from UIImageView, the ones from storyboard.
    @IBOutlet weak var hamster: UIImageView!
    @IBOutlet weak var hamsterplace: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // HighScore
        let storeHighScore = UserDefaults.standard.object(forKey: "HighScore")
        
        if storeHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Recorde: \(highScore)"
        }
        
        // Creating a new high score
        if let newScore = storeHighScore as? Int {
            highScore = Int(newScore)
            highScoreLabel.text = "Recorde: \(highScore)"
        }
        
        // Score text
        self.scoreLabel.text = String(format: "%.f", score)

        // Drag and drop enabled interaction with the images from UIImageView.
        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        hamster.addInteraction(dragInteraction)
        hamster.backgroundColor = UIColor.clear
        
        hamsterplace.contentMode = .scaleAspectFit
        hamsterplace.isUserInteractionEnabled = true
        let configuration = UIPasteConfiguration(forAccepting: UIImage.self)
        hamsterplace.pasteConfiguration = configuration
        
        // Adding gesture recognizers
        addGestureRecognizers()
    }
    
    // Drag Interaction Function
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = hamster.image else { return [] }
        let item = UIDragItem(itemProvider: NSItemProvider(object: image))
        return [item]
    }
    
    // Function to hide dog's shadow when you drop it.
    @objc func hideHamster() {
        hamster.isHidden = true
    }
    
    // Score function
    @objc func increaseScore() {
        score += 10
        scoreLabel.text = "\(score)"
    }
    
    // Next level function
    @objc func nextLevel() {
        let alert = UIAlertController(title: "Você passou para o próximo nível", message: "Gostaria de prosseguir? ", preferredStyle: UIAlertController.Style.alert)
        
        let noButton = UIAlertAction(title: "Não", style: UIAlertAction.Style.default) { (UIAlertAction) in
            // Opening the next view controller, in this case it's the cancel view controller.
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CancelViewController") as! CancelViewController
            nextViewController.highScore = self.score
            nextViewController.modalPresentationStyle = .overFullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        
        let restartButton = UIAlertAction(title: "Sim", style: UIAlertAction.Style.default) { (UIAlertAction) in
            // Opening the next view controller, in this case it's the BirdViewController.
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BirdViewController") as! BirdViewController
            nextViewController.score = self.score
            nextViewController.highScore = self.score
            nextViewController.modalPresentationStyle = .overFullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }
        
        alert.addAction(noButton)
        alert.addAction(restartButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Adding gesture recognizers
    func addGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        hamster.addGestureRecognizer(panGestureRecognizer)
        hamster.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    // GestureHandlerDelegate functions
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        handlePan(gesture)
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        handlePinch(gesture)
    }
}

// Class extension to make multiple gesture happen.
extension HamsterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
