
//
//  Level_1.swift
//  Spot
//
//  Created by Darien Sandifer on 9/23/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class SceneLevel_1:SKScene{
    
    var player = Player();
    var playingArea = GameBoard();
    
    override func didMove(to view: SKView) {
        // Set the scale mode to scale to fit the window
        self.scaleMode = .aspectFill
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        self.addChild(player);
        
        for item in playingArea.board {
            self.addChild(item.node)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.physicsBody?.velocity = CGVector(dx:0,dy:0)
        player.physicsBody?.applyImpulse(CGVector(dx:0,dy:50))
        

    }
}
