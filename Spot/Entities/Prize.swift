//
//  Prize.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit


enum PrizeType {
    case Points
    case ExtraLives
}


class Prize: GKEntity {
    var prizeType:PrizeType? = nil;
    var pHeight = 50;
    var pWidth = 50;
    
    init(value:Points,prizeType:PrizeType,imageName:String) {
        super.init()
        self.prizeType = prizeType
        
        //add the prizes SpriteComponent
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        spriteComponent.node.size = CGSize(width:pWidth,height:pHeight)
        
        let prizeNode = spriteComponent.node
        prizeNode.physicsBody = SKPhysicsBody(circleOfRadius: prizeNode.size.width/2)
        prizeNode.physicsBody?.categoryBitMask = BitMasks.LaserCategory.rawValue
        prizeNode.physicsBody?.contactTestBitMask = BitMasks.PlayerCategory.rawValue
        prizeNode.physicsBody?.isDynamic = true
        prizeNode.physicsBody?.affectedByGravity = false
        
        //setup rotation action
        let oneRevolution:SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
        prizeNode.run(repeatRotation)
        addComponent(spriteComponent)
        
        //setup prize value
        let valueComponent = ValueComponent(points:value)
        addComponent(valueComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
