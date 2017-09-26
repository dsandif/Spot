//
//  Tile.swift
//  Spot
//
//  Created by Darien Sandifer on 9/23/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Tile:GKEntity {
    
   // var node = SKSpriteNode(imageNamed:"MoveSpace")
//    var tHeight = 60;
//    var tWidth = 60;
    
    init(imageName: String) {
        //self.node.size = CGSize(width:tHeight,height:tWidth)
        //self.node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        super.init()
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
    }
}
