
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

class SceneLevel_1:SKScene,SKPhysicsContactDelegate{
    
    var player = Player(imageName:"Rocket");
    var playingArea = GameBoard();
    
    override func didMove(to view: SKView) {
        // Set the scale mode to scale to fit the window
        self.scaleMode = .aspectFill
//        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//
//        borderBody.friction = 0
//
//        self.physicsBody = borderBody
        physicsWorld.contactDelegate = self
        
//        addGestures(view:view)
        
        if let playerSpriteNode = player.component(ofType: SpriteComponent.self)?.node{
            self.addChild(playerSpriteNode);
        }

        
        let label = SKLabelNode(text: "Score:")
        label.position.x = (self.frame.width/4)
        label.position.y = (self.frame.height/2)-50
        addChild(label)
        
    }
    
    //this function should eventually be run at random intervals, variables dealing with velocity will depend on the current level -- higher levels 
    func spawnOrb() {
        let enemyOrb = Orb(imageName:"spaceMeteors_001");
        var orbSpriteNode = enemyOrb.component(ofType: SpriteComponent.self)?.node
        
        let yPosition = randomBetweenNumbers(firstNum: -self.frame.height/2, secondNum:  self.frame.height/2)
        let xPosition = self.frame.width/2
        
        
        //set the position on the y axis that the orb will shoot from
        orbSpriteNode?.position = CGPoint(x:xPosition, y:yPosition)
        
        self.addChild(orbSpriteNode!)
        
        //shoot an orb to the other side of the screen in .5 seconds and fade away in a sequence
        let shootingAction = SKAction.moveBy(x: -self.frame.width, y: 0, duration: 0.5)
        let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.3)
        let remove = SKAction.removeFromParent()
        let shootAndFade = SKAction.sequence([shootingAction,fadeAction,remove])
        
        //run the action
        orbSpriteNode?.run(shootAndFade)

    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //testing only
        spawnOrb()
        
//        player.physicsBody?.velocity = CGVector(dx:0,dy:0)
//        player.physicsBody?.applyImpulse(CGVector(dx:0,dy:50))

    }
    
    func addGestures(view:SKView) {
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let itemA = contact.bodyA
        let itemB = contact.bodyB
        
        //if the contact is between a player and an orb
        if (itemA.categoryBitMask == BitMasks.PlayerCategory.rawValue && itemB.categoryBitMask == BitMasks.OrbCategory.rawValue){

            orbHitPlayer(playerNode: itemA.node!, orbNode: itemB.node!)
        }else if(itemA.categoryBitMask == BitMasks.OrbCategory.rawValue && itemB.categoryBitMask == BitMasks.PlayerCategory.rawValue){
            
            orbHitPlayer(playerNode: itemB.node!, orbNode: itemA.node!)
        }
        
    }
    
    func orbHitPlayer(playerNode:SKNode,orbNode:SKNode) {
        
        //update the players score
        if let playerHealthComponent = player.component(ofType: HealthComponent.self){
            playerHealthComponent.UpdateHealth(amount: -1)
            print(playerHealthComponent.health)
        }
    }
    
}
