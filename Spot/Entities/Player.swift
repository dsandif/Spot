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
        
        var playerNode = spriteComponent.node
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: playerNode.size)
        playerNode.physicsBody?.categoryBitMask = BitMasks.PlayerCategory.rawValue
        playerNode.physicsBody?.contactTestBitMask = BitMasks.OrbCategory.rawValue
        playerNode.physicsBody?.isDynamic = false

        addComponent(spriteComponent)
        
        let movementComponent = MovementComponent()
        addComponent(movementComponent)
        
        let scoreComponent = ScoreComponent(points:Points.StartingPoints);
        addComponent(scoreComponent)
        
        let healthComponent = HealthComponent(health:3)
        addComponent(healthComponent)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
