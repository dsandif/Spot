//
//  Orb.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit

class Orb: GKEntity {
    var pHeight = 50;
    var pWidth = 50;
    
    init(imageName:String) {
        super.init()
        
        //add the orbs image
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        
        //add size
        spriteComponent.node.size = CGSize(width:pWidth,height:pHeight)
        
        addComponent(spriteComponent)
        
        let damageComponent = DamageComponent(power:10)
        addComponent(damageComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
