import Foundation
import UIKit

extension UIViewController {
    // Função para configurar o Gesture Handler para uma determinada view.
    func setupGestureHandler(for view: UIView, with delegate: AnimalGestureHandlerDelegate) -> GestureHandler {
        // Criando um Gesture Handler para a view especificada.
        let gestureHandler = GestureHandler(view: view)
        // Definindo o delegate para receber callbacks dos gestos.
        gestureHandler.delegate = delegate
        // Retornando o Gesture Handler configurado.
        return gestureHandler
    }
    
    // Função para atualizar o texto de um label de score com o score fornecido.
    func updateScoreLabel(_ scoreLabel: UILabel, with score: Int) {
        scoreLabel.text = "\(score)" // Define o texto do label de score como o score fornecido.
    }
    
    // Método estático para verificar se o animal está na sombra e atualizar o score.
    static func checkIfAnimalIsInPlace(animalView: UIImageView, animalPlace: UIImageView, currentScore: inout Int, withPoints points: Int, scoreLabel: UILabel) {
        // Calculando o centro da view do animal.
        let animalCenter = CGPoint(x: animalView.frame.midX, y: animalView.frame.midY)
        // Verificando se o centro do animal está dentro da área designada.
        if animalPlace.frame.contains(animalCenter) {
            // Escondendo a sombra
            animalPlace.isHidden = true
            // Adicionando os pontos especificados ao score.
            currentScore += points
            // Atualizando o texto do label de score com o novo score.
            scoreLabel.text = "\(currentScore)"
            print("Pontuação atualizada para \(currentScore)")
        }
    }
    
    // Função para verificar a condição de transição para uma determinada pontuação e chamar um manipulador de transição.
    func checkTransitionCondition(currentScore: Int, targetScore: Int, transitionHandler: () -> Void) {
        // Verificando se o score atual é maior ou igual à pontuação alvo.
        if currentScore >= targetScore {
            // Chamando o manipulador de transição.
            transitionHandler()
        }
    }
    
}
