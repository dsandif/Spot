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
    var boundary: CGRect? = nil
    
    override init(){
        super.init()

    }
    
    func MoveTo(newDirection:Direction){
        var newPosition:CGPoint
        currentPosition = self.entity?.component(ofType: SpriteComponent.self)?.node.position
        
        switch newDirection {
            case .Left:
                newPosition = CGPoint(x:(currentPosition?.x)! - 50.0,y: (currentPosition?.y)!)
            case .Right:
                newPosition = CGPoint(x:(currentPosition?.x)! + 50.0,y: (currentPosition?.y)!)
            case .Up:
                newPosition = CGPoint(x:(currentPosition?.x)! ,y: (currentPosition?.y)! + 50.0)
            case .Down:
                newPosition = CGPoint(x:(currentPosition?.x)! ,y: (currentPosition?.y)! - 50.0)
        }
        
        //round to prevent odd values
        newPosition.x.round()
        newPosition.y.round()

        //only move if the new position is within the screens bounds
        if (boundary?.contains(newPosition))! {
            //setup the movement action to the new position
            if let currentNode = self.entity?.component(ofType: SpriteComponent.self)?.node{
                
                let moveAction = SKAction.move(to: newPosition, duration: 0.1)
                
                //run the action
                currentNode.run(moveAction)
                
                //update the current position
                currentPosition = newPosition
            }
        }
        

        
        print("current Position:", newPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
