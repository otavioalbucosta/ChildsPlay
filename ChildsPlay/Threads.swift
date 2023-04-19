//
//  ThreadProtocol.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation
import SwiftUI


var currentBasket = Basket(maxCapacity: 2)
// Semáforo padrão do Swift
var basketSemaphore = DispatchSemaphore(value: 0)


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
                    self.ball = false
                    currentBasket.addBall()
                    basketSemaphore.signal()
                    // 
                    self.rest()
                }else {
                    basketSemaphore.wait()
                    currentBasket.removeBall()
                    self.ball = true
                }
            }
        }
    }
    
    func updateView() {
        
//        self.list.children = self.list.children.map({$0})
    }
    
}
