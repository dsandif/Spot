//
//  Player.swift
//  Spot
//
//  Created by Darien Sandifer on 9/23/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Player: GKEntity {
    
    var pHeight = 50;
    var pWidth = 50;
    
    init(imageName:String) {
        super.init()
        
        //add the Players image
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        
        //add size
        spriteComponent.node.size = CGSize(width:pWidth,height:pHeight)
        
        addComponent(spriteComponent)
        
        let movementComponent = MovementComponent()
        addComponent(movementComponent)
        
        let scoreComponent = ScoreComponent(points:0);
        addComponent(scoreComponent)
        
        let healthComponent = HealthComponent(health:0)
        addComponent(healthComponent)
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
