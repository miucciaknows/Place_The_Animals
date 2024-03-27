//
//  ViewController.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 22/03/24.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    // Imagem do hamster do ViewController inicial
    @IBOutlet weak var hamster: UIImageView!
    
    // Propriedades
    //Variável para reprodução de áudio
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
         // Configuração da interface
         setupUI()
         
         // Configuração do áudio
         setupAudio()
     }
     
     // Função para configurar a interface
     private func setupUI() {
         // Adicionando interação à imagem do hamster com UITap
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
         hamster.addGestureRecognizer(tapGesture)
         hamster.isUserInteractionEnabled = true
     }
     
     // Função para configurar o áudio
     private func setupAudio() {
         // Carregando e preparando o arquivo de áudio
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
     
     // Função que é chamada quando a imagem do hamster é tocada
     @objc func handleTap(_ gesture: UITapGestureRecognizer) {
         // Reproduzindo som
         audioPlayer?.play()
         
         // Alterando a imagem do hamster
         hamster.image = UIImage(named: "hamster")
         
         // Mudando de ViewController para DogViewController
         transitionToDogViewController()
     }
     
     // Função para fazer a transição para DogViewController
     private func transitionToDogViewController() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let dogViewController = storyboard.instantiateViewController(withIdentifier: "DogViewController") as? DogViewController {
             print("DogViewController instanciado com sucesso.")
             present(dogViewController, animated: true, completion: nil)
         } else {
             print("Erro ao instanciar DogViewController")
         }
     }
 }
