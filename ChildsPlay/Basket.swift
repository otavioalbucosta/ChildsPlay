//
//  Basket.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation

class Basket {
    
    var ballCount: Int
    var maxCapacity: Int
    
    init(ballCount: Int = 0, maxCapacity: Int = 0) {
        self.ballCount = ballCount
        self.maxCapacity = maxCapacity
    }

}
