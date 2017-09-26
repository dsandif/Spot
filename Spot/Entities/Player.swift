//
//  Player.swift
//  Spot
//
//  Created by Darien Sandifer on 9/23/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {

    var points = 0;
    var health = 0;
    var pHeight = 50;
    var pWidth = 50;
    
    init() {
        let texture = SKTexture(imageNamed: "Spaceship")
        
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width:pWidth,height:pHeight))
        self.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width:pWidth,height:pHeight))
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.allowsRotation = true
        self.position = CGPoint(x: 0, y: 0);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
