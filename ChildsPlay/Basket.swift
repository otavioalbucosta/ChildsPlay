//
//  Basket.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation

class Basket: ObservableObject {
    
   @Published var ballCount: Int
   @Published var maxCapacity: Int
    var existentBalls: Int = 0
    
    func addBall() -> Bool{
        if existentBalls <= maxCapacity{
            ballCount += 1
            return true
        }else{
            print("No balls")
            return false
        }
        
    }
    
    func newBall() {
        
    }
    
    func removeBall() -> Bool{
        if ballCount > 0 {
            ballCount -= 1
            return true
        }else{
            return false
        }

    }
    
    
    
    init(ballCount: Int = 0, maxCapacity: Int = 0) {
        self.ballCount = ballCount
        self.maxCapacity = maxCapacity
    }

}
