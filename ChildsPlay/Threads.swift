//
//  ThreadProtocol.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation
import SwiftUI



// Semáforo padrão do Swift
var basketSemaphore = DispatchSemaphore(value: 0)
var basketOperationsSemaphore = DispatchSemaphore(value: 1)


protocol Thread {
    func run()
    func updateView()
}

extension Child: Thread {
    // Lógica do semáforo
    func run() {
        //Cria threads assíncronas no Swift
        //roda em background do app
        DispatchQueue(label: "com.ChildsPlay.ChildsPlaying", qos: .utility, attributes: .concurrent).async {
            while(true){
                // checa se a criança tem bola
                if self.ball == true {
                    
                    self.play()
                    //após terminar de brincar, a criança tira a bola, adiciona no Basket e da Up no semáforo para avisar às outras threads

                    if Basket.shared.addBall() {
                        self.ball = false
                        basketSemaphore.signal()

                    }else{
                        self.waitBasket()
                        basketOperationsSemaphore.wait()
                        Basket.shared.addBall()
                        self.ball = false
                        basketSemaphore.signal()

                        basketOperationsSemaphore.signal()
                    }

                    // 
                    self.rest()
                }else {
                    basketSemaphore.wait()
                    if Basket.shared.removeBall() {
                        self.ball = true
                    }
                }
            }
        }
    }
    
    func updateView() {
        
        self.list.children = self.list.children.map({$0})
    }
    
}
