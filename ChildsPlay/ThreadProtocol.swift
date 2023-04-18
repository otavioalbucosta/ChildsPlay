//
//  ThreadProtocol.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation



let currentBasket = Basket()
let basketSemaphore = DispatchSemaphore(value: 0)


protocol Thread {
    func run()
    func updateView()
}

extension Child: Thread {
    func run() {
        DispatchQueue.global(qos: .background).async {
            while(!self.isDead){
                if self.ball == true {
                    self.play()
                    basketSemaphore.signal()
                    self.ball = false
                    currentBasket.addBall()
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
        
    }
    
}
