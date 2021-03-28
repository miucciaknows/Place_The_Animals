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
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }










}


