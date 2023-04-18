//
//  ThreadProtocol.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation

let basketSemaphore = DispatchSemaphore(value: 0)
protocol Thread {
    func run()
    func updateView()
}

extension Child: Thread {
    func run() {
        DispatchQueue.global(qos: .background).async {
            while(!self.isDead){
                
                
            }
        }
    }
    
    func updateView() {

    }
    
}
