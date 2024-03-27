//
//  GestureHandler.swift
//  Place_the_Animals
//
//  Created by Nathalia Trazzi on 26/03/24.
//

import UIKit

// Protocolo utilizado para notificar quando o animal é colocado em sua sombra
protocol AnimalGestureHandlerDelegate: AnyObject {
    // Função para verificar se o animal está em sua sombra
    func checkIfAnimalIsInPlace()
}

class GestureHandler: NSObject {
    // Delegado para receber notificações sobre o animal
    weak var delegate: AnimalGestureHandlerDelegate?
    
    // Inicializador da classe que configura o gesto de arrastar para a sombra do animal
    init(view: UIView) {
        super.init()
        // Adicionando o gesto de arrastar à visualização fornecida
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        // Habilitando a interação do usuário na visualização
        view.isUserInteractionEnabled = true
    }
    
    // Função chamada quando o gesto de arrastar é reconhecido
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let draggedView = gesture.view else { return }
        
        // Calculando a translação do gesto em relação à superView da visualização
        let translation = gesture.translation(in: draggedView.superview)
        
        // Movendo a visualização arrastada com base na translação calculada
        draggedView.center = CGPoint(x: draggedView.center.x + translation.x, y: draggedView.center.y + translation.y)
        
        // Resetando a translação do gesto
        gesture.setTranslation(.zero, in: draggedView.superview)
        
        // Se o gesto de arrastar é finalizado, verifica se o animal está no lugar correto, na sombra
        if gesture.state == .ended {
            delegate?.checkIfAnimalIsInPlace()
        }
    }
}
