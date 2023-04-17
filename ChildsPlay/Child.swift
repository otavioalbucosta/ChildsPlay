//
//  Child.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation

protocol Thread {
    func run()
    func updateView()
}

class Child: Thread {
    
    var id = UUID()
    var ball: Bola?
    var timePlaying: Int
    var timeResting: Int
    
    init(ball: Bola? = nil, timePlaying: Int, timeResting: Int) {
        self.ball = ball
        self.timePlaying = timePlaying
        self.timeResting = timeResting
    }
    
    func run() {
        <#code#>
    }
    
    func updateView() {
        <#code#>
    }
    
}
