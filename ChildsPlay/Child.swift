//
//  Child.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation
import SwiftUI

enum states {
    case hasBallIsPlaying
    case hasBallCantPlay
    case waiting
    case resting
}


class Child: Identifiable{
    
    var id = UUID()
    var ball: Bool
    var timePlaying: Int
    var timeResting: Int
    var currentTime: Int = 0
    var isWaiting: Bool = false
    var canPlay: Bool = true
    var list: ChildrenList
    lazy var state: states = {
        return .waiting
    }()
    
    
    
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
        state = .hasBallIsPlaying
        currentTime = timePlaying
        let time = Date()
        var actualTime = time
        isWaiting = false
        
        while(Int(-time.timeIntervalSinceNow) < timePlaying){
            if -actualTime.timeIntervalSinceNow >= 1{
                self.currentTime -= 1
                actualTime = Date()
                DispatchQueue.main.async {
                    self.updateView()
                }
                print("Brincando, tempo restante: \(-time.timeIntervalSinceNow)")
            }
            //O sleep é no while, que é no processo principal, a Thread NUNCA da sleep
            //O sleep é feito pro while não gerar Threads incessantemente
            //            sleep(1)
        }
        canPlay = false
        state = .hasBallCantPlay
    }
    
    func rest() {
        state = .resting
        currentTime = timeResting
        let time = Date()
        var actualTime = time
        while(Int(-time.timeIntervalSinceNow) < timeResting){
            if -actualTime.timeIntervalSinceNow >= 1{
                currentTime -= 1
                actualTime = Date()
                DispatchQueue.main.async {
                    self.updateView()
                }
                print("Descansando, tempo restante: \(-time.timeIntervalSinceNow)")
            }
            
            //            sleep(1)
        }
        canPlay = true
        isWaiting = true
        state = .waiting
    }
    
//    func waitBasket() {
//        canPlay = false
//        let time = Date()
//        var actualTime = time
//        if self.ball == true {
//            while(Basket.shared.ballCount == Basket.shared.maxCapacity){
////                if !canPlay {break}
//                if -actualTime.timeIntervalSinceNow >= 1{
//                    currentTime = 0
//                    actualTime = Date()
//                    DispatchQueue.main.async {
//                        self.updateView()
//                    }
//                    print("Esperando o cesto abrir espaço, tempo atual: \(-time.timeIntervalSinceNow)")
//                }
//            }
//        }
//    }
    
    
}
