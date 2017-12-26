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
    
    func MoveTo(newDirection:Direction) -> Bool{
        var didMove = false;
        var newPosition:CGPoint
        var rotationAngle = CGFloat(0);
        currentPosition = self.entity?.component(ofType: SpriteComponent.self)?.node.position
        
        switch newDirection {
            case .Left:
                newPosition = CGPoint(x:(currentPosition?.x)! - 50.0,y: (currentPosition?.y)!)
                rotationAngle = CGFloat(Double.pi / 2)
            case .Right:
                newPosition = CGPoint(x:(currentPosition?.x)! + 50.0,y: (currentPosition?.y)!)
                rotationAngle = -CGFloat(Double.pi / 2)
            case .Up:
                newPosition = CGPoint(x:(currentPosition?.x)! ,y: (currentPosition?.y)! + 50.0)
                rotationAngle = 0.0
            case .Down:
                newPosition = CGPoint(x:(currentPosition?.x)! ,y: (currentPosition?.y)! - 50.0)
                rotationAngle = CGFloat(Double.pi)
        }
        
        //round to prevent odd values
        newPosition.x.round()
        newPosition.y.round()

        //only move if the new position is within the screens bounds
        if (boundary?.contains(newPosition))! {
            //setup the movement action to the new position
            if let currentNode = self.entity?.component(ofType: SpriteComponent.self)?.node{
                
                //rotate
                let turnAction:SKAction = SKAction.rotate(byAngle: CGFloat(rotationAngle) , duration: 0)
                //move character
                let moveAction = SKAction.move(to: newPosition, duration: 0.13)
                //rotate back to the original position
                //let turnbackAction = SKAction.rotate(byAngle: -CGFloat(rotationAngle), duration: 0.0)
                let turnbackAction = SKAction.rotate(toAngle: 0, duration: 0)
                //setup the previous 3 lines as a movement action
                let movementSequence = SKAction.sequence([turnAction,moveAction,turnbackAction])
                
                //run the action
                currentNode.run(movementSequence)
                
                //update the current position
                currentPosition = newPosition
                didMove = true
            }
        }else{
            didMove = false
        }
        
        return didMove
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
