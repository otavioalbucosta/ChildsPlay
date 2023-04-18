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
    private var currentTime: Int = 0
    
    private(set) var isDead: Bool = false
    
    init(ball: Bool = false, timePlaying: Int, timeResting: Int) {
        self.ball = ball
        self.timePlaying = timePlaying
        self.timeResting = timeResting
    }
    
    deinit {
        isDead = true
    }
    @objc func incrementTimer() {
        self.currentTime += 1

    }
    
    func restartTimer() {
        self.currentTime = 0
    }
    
    func play() {
        while(currentTime < timePlaying){
            Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(incrementTimer), userInfo: nil, repeats: true)
            print("Brincando, tempo restante: \(currentTime)")
        }
    }
    
    func rest() {
        while(currentTime < timeResting){
            Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(incrementTimer), userInfo: nil, repeats: true)
            print("Descansando, tempo restante: \(currentTime)")
        }
    }
    
}
