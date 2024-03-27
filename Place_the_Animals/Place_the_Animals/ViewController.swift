//
//  ViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var hamster: UIImageView!
    
    var audioPlayer: AVAudioPlayer?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          

          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
          hamster.addGestureRecognizer(tapGesture)
          hamster.isUserInteractionEnabled = true
          

          if let soundURL = Bundle.main.url(forResource: "funny-spring-jump", withExtension: "mp3") {
              do {
                  audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                  audioPlayer?.prepareToPlay()
              } catch {
                  print("Erro ao carregar o arquivo de som: \(error.localizedDescription)")
              }
          } else {
              print("Arquivo de som não encontrado")
          }
      }
      
      @objc func handleTap(_ gesture: UITapGestureRecognizer) {
          audioPlayer?.play()
          
          hamster.image = UIImage(named: "hamster")
          
          transitionToDogViewController()
      }
    
    
    func transitionToDogViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let dogViewController = storyboard.instantiateViewController(withIdentifier: "DogViewController") as? DogViewController {
            print("DogViewController instanciado com sucesso.")
            present(dogViewController, animated: true, completion: nil)
        } else {
            print("Erro ao instanciar DogViewController")
        }
    }
    
    
    
  }
