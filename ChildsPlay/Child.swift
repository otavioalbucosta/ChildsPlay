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
     var currentTime: Date? = nil
     var isWaiting: Bool = false
     var list: ChildrenList
    
    
    init(ball: Bool, timePlaying: Int, timeResting: Int, list: ChildrenList) {
        self.ball = ball
        self.timePlaying = timePlaying
        self.timeResting = timeResting
        self.list = list
    }
    
//   @objc func decrementTimer() {
//        self.currentTime -= 1
//
//        
//    }
    
    
    
    func play() {
        let time = Date()
        isWaiting = false
        print(time.timeIntervalSinceNow)
        
        while(Int(-time.timeIntervalSinceNow) < timePlaying){
            print("Brincando, tempo restante: \(time.timeIntervalSinceNow)")
//            DispatchQueue.main.async {
//                self.updateView()
//            }
            //O sleep é no while, que é no processo principal, a Thread NUNCA da sleep
            //O sleep é feito pro while não gerar Threads incessantemente
//            sleep(1)
        }
    }
    
    func rest() {
        let time = Date()
        while(Int(-time.timeIntervalSinceNow) < timeResting){
            print("Descansando, tempo restante: \(time.timeIntervalSinceNow)")
            

//            sleep(1)
        }
        isWaiting = true
    }
    
    
}
