//
//  ThreadsController.swift
//  ChildsPlay
//
//  Created by Otávio Albuquerque on 17/04/23.
//

import Foundation

struct ThreadController {
    private var childQueue: [Child] = []
    private var playingKids: [Child] = []
    
    mutating func queue(child: Child){
        childQueue.append(child)
    }
    mutating func dequeue() -> Child{
        return childQueue.removeFirst()
    }
    let currentBasket: Basket
    
    
    
}
