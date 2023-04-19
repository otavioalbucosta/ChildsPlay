//
//  ThreadProtocol.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation
import SwiftUI


var currentBasket = Basket(maxCapacity: 5)
var basketSemaphore = DispatchSemaphore(value: 0)


protocol Thread {
    func run()
    func updateView()
}

extension Child: Thread {
    func run() {
        DispatchQueue.global(qos: .background).async {
            while(true){
                if self.ball == true {
                    self.play()
                    self.ball = false
                    currentBasket.addBall()
                    basketSemaphore.signal()
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
        
        self.list.children = self.list.children.map({$0})
    }
    
}
