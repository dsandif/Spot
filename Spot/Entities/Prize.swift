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
    var value: Int = 0;
    
    init(value:Int,prizeType:PrizeType,imageName:String) {
        super.init()
        self.prizeType = prizeType
        self.value = value;
        
        //add the prizes SpriteComponent
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
