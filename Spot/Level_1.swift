
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
    let label = SKLabelNode(text: "Score:")
    var prizeTimer = Timer()
    
    override func didMove(to view: SKView) {
        
        // Set the scale mode to scale to fit the window
        self.scaleMode = .aspectFill
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        
        self.physicsBody = borderBody
        physicsWorld.contactDelegate = self
        
        //add the player to the screen with a boundary of play
        if let playerSpriteNode = player.component(ofType: SpriteComponent.self)?.node{
            player.component(ofType: MovementComponent.self)?.boundary = frame
            self.addChild(playerSpriteNode);
        }

        
        //add score label
//        let playerScore = player.component(ofType: HealthComponent.self)?.health
        label.position.x = (self.frame.width/4)
        label.position.y = (self.frame.height/2)-50
        addChild(label)
        
        addGestures(view:view)
        
        
        startPrizeTimer()
        
        
    }
    
    func startPrizeTimer(){
        let timeIntervalInSeconds = 15.0
        let selector = #selector(self.spawnPrize)
        prizeTimer = Timer.scheduledTimer(timeInterval: timeIntervalInSeconds, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func spawnPrize() {
        
        var newPrize = Prize()
    }
    
    // this function should eventually be run at random intervals, variables dealing with
    // velocity will depend on the current level -- higher levels
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
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        var upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        var downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        
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

        }
    }
    
    
    func updateScoreLabel() {
        
        let playerScore = player.component(ofType: ScoreComponent.self)?.points
        label.text = "Score:" + "\(playerScore!)"
    }
    
    func swipeLeft(sender: UIGestureRecognizer){
        
        let movementComponent = player.component(ofType: MovementComponent.self)
        var didMove = movementComponent?.MoveTo(newDirection: .Left)
        
        //give the player points for making a move
        if didMove == true {
            let scoringComponent = player.component(ofType: ScoreComponent.self)
            scoringComponent?.UpdatePoints(amount: Points.MovementPoint)
            
            //update the label
            updateScoreLabel()
        }
    }
    
    func swipeRight(sender: UIGestureRecognizer){
        
        let movementComponent = player.component(ofType: MovementComponent.self)
        var didMove = movementComponent?.MoveTo(newDirection: .Right)
        
        //give the player points for making a move
        if didMove == true {
            let scoringComponent = player.component(ofType: ScoreComponent.self)
            scoringComponent?.UpdatePoints(amount: Points.MovementPoint)
            
            //update the label
            updateScoreLabel()
        }
    }
    
    func swipeUp(sender: UIGestureRecognizer){
        let movementComponent = player.component(ofType: MovementComponent.self)
        var didMove = movementComponent?.MoveTo(newDirection: .Up)
        
        //give the player points for making a move
        if didMove == true {
            let scoringComponent = player.component(ofType: ScoreComponent.self)
            scoringComponent?.UpdatePoints(amount: Points.MovementPoint)
            
            //update the label
            updateScoreLabel()
        }
    }
    
    func swipeDown(sender: UIGestureRecognizer){
        let movementComponent = player.component(ofType: MovementComponent.self)
        var didMove = movementComponent?.MoveTo(newDirection: .Down)
        
        //give the player points for making a move
        if didMove == true {
            let scoringComponent = player.component(ofType: ScoreComponent.self)
            scoringComponent?.UpdatePoints(amount: Points.MovementPoint)
            
            //update the label
            updateScoreLabel()
        }
    }
}
