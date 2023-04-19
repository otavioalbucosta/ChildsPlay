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
    
    func decrementTimer() {
        self.currentTime -= 1
        
    }
    
    
    
    func play() {
        currentTime = timePlaying
        isWaiting = false
        while(currentTime > 0){
            print("Brincando, tempo restante: \(self.currentTime)")
            self.decrementTimer()
            self.updateView()
            //O sleep é no while, que é no processo principal, a Thread NUNCA da sleep
            //O sleep é feito pro while não gerar Threads incessantemente
//            sleep(1)
        }
    }
    
    func rest() {
        currentTime = timeResting
        while(currentTime > 0){
            print("Descansando, tempo restante: \(self.currentTime)")
            self.decrementTimer()
            DispatchQueue.main.async {
                self.updateView()
            }

//            sleep(1)
        }
        isWaiting = true
    }
    
    
}
