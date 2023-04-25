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
    

    
    func setCapacity(quantity: Int) {
        self.maxCapacity = quantity
    }
    
    
    
    init(ballCount: Int = 0, maxCapacity: Int = 0) {
        self.ballCount = ballCount
        self.maxCapacity = maxCapacity
    }

}
