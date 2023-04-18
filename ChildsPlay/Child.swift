//
//  Child.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation



class Child {
    
    var id = UUID()
    var ball: Bool
    var timePlaying: Int
    var timeResting: Int
    
    private(set) var isDead: Bool = false
    
    init(ball: Bool = false, timePlaying: Int, timeResting: Int) {
        self.ball = ball
        self.timePlaying = timePlaying
        self.timeResting = timeResting
    }
    
    deinit {
        isDead = true
    }
    
    func play() {
        
    }
    
}
