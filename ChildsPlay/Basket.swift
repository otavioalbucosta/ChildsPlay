//
//  Basket.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation

class Basket: ObservableObject {
    
    static var shared = Basket()
    
   @Published var ballCount: Int
   @Published var maxCapacity: Int
    var existentBalls: Int = 0
    
    func addBall() -> Bool{
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
    
    func setCapacity(quantity: Int) {
        self.maxCapacity = quantity
    }
    
    
    
    init(ballCount: Int = 0, maxCapacity: Int = 0) {
        self.ballCount = ballCount
        self.maxCapacity = maxCapacity
    }

}
