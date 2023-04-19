//
//  Child.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation
import SwiftUI


class Child: Identifiable{
    
    var id = UUID()
     var ball: Bool
    var timePlaying: Int
    var timeResting: Int
     var currentTime: Int = 0
     var isWaiting: Bool = false
     var list: ChildrenList
    
    
    init(ball: Bool, timePlaying: Int, timeResting: Int, list: ChildrenList) {
        self.ball = ball
        self.timePlaying = timePlaying
        self.timeResting = timeResting
        self.list = list
    }
    
    @objc func decrementTimer() {
        self.currentTime -= 1
        
    }
    
    
    
    func play() {
        currentTime = timePlaying
        isWaiting = false
        while(currentTime > 0){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                print("Brincando, tempo restante: \(self!.currentTime)")
                self!.decrementTimer()
                self?.updateView()
            }
            sleep(1)
        }
    }
    
    func rest() {
        currentTime = timeResting
        while(currentTime > 0){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                print("Descansando, tempo restante: \(self!.currentTime)")
                self!.decrementTimer()
                self?.updateView()
            }
            sleep(1)
        }
        isWaiting = true
    }
    
    
}
