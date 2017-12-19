//
//  MovementComponent.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit


enum Direction {
    case Up
    case Down
    case Left
    case Right
}

enum Speed{
    case Fast
    case Medium
    case Slow
}

class MovementComponent: GKComponent {
    
    var speed:Speed?
    var direction: Direction?
    var currentPosition:CGPoint?
    var canMove:Bool = true
    
    override init(){
        super.init()
    }
    
    func MoveTo(newPosiion:CGPoint){
        
        if let currentNode = self.entity?.component(ofType: SpriteComponent.self)?.node{
            
            let moveAction = SKAction.move(to: newPosiion, duration: 0.1)
            
            //run the action
            currentNode.run(moveAction)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
