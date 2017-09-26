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
    var currentPosition:Tile
    var canMove:bool
    
    init(position:Tile){
        self.currentPosition = position
        super.init()
    }
    
    func MoveTo(posiion:Tile){
        self.currentPosition = posiion
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
