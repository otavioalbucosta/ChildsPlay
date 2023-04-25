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
var basketFullSemaphore: DispatchSemaphore!
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
                    if self.canPlay {
                        self.play()
                    }
                    //após terminar de brincar, a criança tira a bola, adiciona no Basket e da Up no semáforo para avisar às outras threads
                    basketSemaphore.signal()
                    basketFullSemaphore.wait()
                    if Basket.shared.addBall() {
                        self.ball = false
                    }

                    // 
                    self.rest()
                }else {
                    basketSemaphore.wait()
                    basketFullSemaphore.signal()
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

extension Basket {
    func addBall() -> Bool {
        if ballCount < maxCapacity{
            ballCount += 1
            return true
        }else{

            print("Ball limit")
            return false
        }
        
    }
    
    
    func removeBall() -> Bool{
        if ballCount > 0 {
            ballCount -= 1
            return true
        }else{
            return false
        }

    }
}
