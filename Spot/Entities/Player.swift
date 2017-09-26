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
    
    init((imageName:String)) {
        super.init()
      //add the Players image
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
    
//        let texture = SKTexture(imageNamed: "Spaceship")
        //super.init(texture: texture, color: SKColor.clear, size: CGSize(width:pWidth,height:pHeight))
        //self.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width:pWidth,height:pHeight))
        //self.physicsBody?.isDynamic = true;
//        self.physicsBody?.allowsRotation = true
//        self.position = CGPoint(x: 0, y: 0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
