//
//  ViewController.swift
//  PlaceTheAnimals
//
//  Created by Miuccia  on 26/03/21.
//

import UIKit

class ViewController: UIViewController, UIDragInteractionDelegate {
    
    @IBOutlet weak var dog: UIImageView!
    @IBOutlet weak var dogplace: UIImageView!
    
  
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = dog.image else { return [] }
        let item = UIDragItem(itemProvider: NSItemProvider(object: image))
        return [item]
    }

    
    override func viewDidLoad() {
            super.viewDidLoad()
        
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
          
}
    
    override func paste(itemProviders: [NSItemProvider]) {
            _ = itemProviders.first?.loadObject(ofClass: UIImage.self, completionHandler: { (image: NSItemProviderReading?, error: Error?) in
                DispatchQueue.main.async {
                    self.dogplace.image = image as? UIImage
                }
            })
        }

}
