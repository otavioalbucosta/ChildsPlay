//
//  Basket.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation

class Basket: Thread {
    
    var ballQueue: [Bola] = []
    var maxCapacity: Int
    
    init(maxCapacity: Int) {
        self.maxCapacity = maxCapacity
    }
    
    
    func run() {
        
    }
    
    func updateView() {
        
    }
}
