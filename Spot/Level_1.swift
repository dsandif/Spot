
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
    let label = SKLabelNode(text: "Score:")
    var prizeTimer = Timer()
    var currentPrizeNodes = [SKSpriteNode]()
    var currentPrizeLimit = 5
    var lives = [SKSpriteNode]()
    var lifeFrequencyCounter = 0
    let addLifeFrequency = 4
    
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
        label.position.x = (self.frame.width/4)
        label.position.y = (self.frame.height/2)-50
        addChild(label)
        
        
        for index in 0...2 {
            //add 3 health icons based on the players image
            var lifeIcon = SKSpriteNode()
            lifeIcon.texture = player.component(ofType: SpriteComponent.self)?.node.texture?.copy() as! SKTexture
            lifeIcon.size.height = 15.0
            lifeIcon.size.width = 15.0
            lifeIcon.position.x = (self.frame.width/4) + (lifeIcon.size.width * (CGFloat)(index))
            lifeIcon.position.y = label.position.y - 15
            
            lives.append(lifeIcon)
            self.addChild(lifeIcon)
        }
        
        
        
        addGestures(view:view)
        
        
        startPrizeTimer()
        
        
    }
    
    func startPrizeTimer(){
        let timeIntervalInSeconds = 2.0
        let selector = #selector(self.spawnPrize)
        prizeTimer = Timer.scheduledTimer(timeInterval: timeIntervalInSeconds, target: self, selector: selector, userInfo: nil, repeats: true)
        
        
    }
    
    func removePrize() {
        //get a random number between 0 and the size of the array
        let randomPrize = currentPrizeNodes[Int(arc4random_uniform(UInt32(currentPrizeNodes.count)))]
        randomPrize.removeFromParent()
    }
    
    @objc func spawnPrize() {
        
        if currentPrizeNodes.count < currentPrizeLimit {
            let newPrize = Prize()
            let prizeSpriteNode = newPrize.component(ofType: SpriteComponent.self)?.node
            
            let yPosition = randomBetweenNumbers(firstNum: -self.frame.height/2, secondNum:  self.frame.height/2)
            let xPosition = randomBetweenNumbers(firstNum: -self.frame.width/2, secondNum:  self.frame.width/2)
            
            prizeSpriteNode?.position = CGPoint(x:xPosition,y:yPosition)
        
            //add it to the list of nodes up to the prize Limit
            if prizeSpriteNode?.physicsBody?.categoryBitMask == BitMasks.ExtraLifeCategory.rawValue{
                for item in currentPrizeNodes{
                    if(item.physicsBody?.categoryBitMask == BitMasks.ExtraLifeCategory.rawValue){
                        return
                    }
                }
                
                if lifeFrequencyCounter == addLifeFrequency{
                    self.addChild(prizeSpriteNode!)
                    currentPrizeNodes.append(prizeSpriteNode!)
                    lifeFrequencyCounter = 0
                }else{
                    lifeFrequencyCounter = lifeFrequencyCounter + 1
                }
                
            }else{
                self.addChild(prizeSpriteNode!)
                currentPrizeNodes.append(prizeSpriteNode!)
            }
        }
    }
    
    // this function should eventually be run at random intervals, variables dealing with
    // velocity will depend on the current level -- higher levels
    func spawnOrb() {
        let enemyOrb = Orb(imageName: PrizeImage.EnemyOrb.rawValue);
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
        
        //contact between player and Bolt
        if (itemA.categoryBitMask == BitMasks.PlayerCategory.rawValue && itemB.categoryBitMask == BitMasks.BoltCategory.rawValue){
            
            playerPrizeContact(playerNode: itemA.node!, prizeNode: itemB.node!)
            
        }else if(itemA.categoryBitMask == BitMasks.BoltCategory.rawValue && itemB.categoryBitMask == BitMasks.PlayerCategory.rawValue){
            
            playerPrizeContact(playerNode: itemB.node!, prizeNode: itemA.node!)
        }
        
        
        //contact between player and Laser
        if (itemA.categoryBitMask == BitMasks.PlayerCategory.rawValue && itemB.categoryBitMask == BitMasks.LaserCategory.rawValue){
            
            playerPrizeContact(playerNode: itemA.node!, prizeNode: itemB.node!)
            
        }else if(itemA.categoryBitMask == BitMasks.LaserCategory.rawValue && itemB.categoryBitMask == BitMasks.PlayerCategory.rawValue){
            
            playerPrizeContact(playerNode: itemB.node!, prizeNode: itemA.node!)
        }
        
        
        //contact between player and Star
        if (itemA.categoryBitMask == BitMasks.PlayerCategory.rawValue && itemB.categoryBitMask == BitMasks.StarCategory.rawValue){
            
            playerPrizeContact(playerNode: itemA.node!, prizeNode: itemB.node!)
            
        }else if(itemA.categoryBitMask == BitMasks.StarCategory.rawValue && itemB.categoryBitMask == BitMasks.PlayerCategory.rawValue){
            
            playerPrizeContact(playerNode: itemB.node!, prizeNode: itemA.node!)
        }
    }
    
    func playerPrizeContact(playerNode:SKNode,prizeNode:SKNode){
        //get the category from the bitmask on the physics body
        var pointsCollected:Points
        
        switch prizeNode.physicsBody?.categoryBitMask {
            
            case BitMasks.BoltCategory.rawValue?:
                pointsCollected = Points.BoltPoints
            
            case BitMasks.LaserCategory.rawValue?:
                pointsCollected = Points.LaserPoints
            
            case BitMasks.StarCategory.rawValue?:
                pointsCollected = Points.StarPoints
            
        default:
            pointsCollected = Points.StartingPoints
        }
        
        //add the points to the players scoring component
        if let playerScoreComponent = player.component(ofType: ScoreComponent.self){
            playerScoreComponent.CollectPrize(amount: pointsCollected)
            updateScoreLabel()
            prizeNode.removeFromParent()
            currentPrizeNodes.remove(at: currentPrizeNodes.index(of: prizeNode as! SKSpriteNode)!)
            

        }
        
        
        
    }
    
    func orbHitPlayer(playerNode:SKNode,orbNode:SKNode) {
        var fadeInDuration = 0.0
        var fadeOutDuration = 0.0
        
        //update the players health
        if let playerHealthComponent = player.component(ofType: HealthComponent.self){
            playerHealthComponent.UpdateHealth(amount: -1)
            lives.popLast()?.removeFromParent()
            
            
            switch lives.count {
                
                case 0:
                    endGame()
                
                case 1:
                    fadeOutDuration = 0.3
                    fadeInDuration = 0.4
                    fadePlayer(fadeInDuration: fadeInDuration,fadeOutDuration: fadeOutDuration)
                
                case 2:
                    fadeOutDuration = 0.5
                    fadeInDuration = 0.6
                    fadePlayer(fadeInDuration: fadeInDuration,fadeOutDuration: fadeOutDuration)

                default:
                    player.component(ofType: SpriteComponent.self)?.node.removeAction(forKey: "fadeSequence")
                    player.component(ofType: SpriteComponent.self)?.node.run(SKAction.fadeIn(withDuration: 0.0))
            }
            
            
        }
    }
    
    func fadePlayer(fadeInDuration:Double,fadeOutDuration:Double) {
        player.component(ofType: SpriteComponent.self)?.node.removeAction(forKey: "fadeSequence")
        //start fading the player
        let sequence = SKAction.repeatForever(SKAction.sequence([SKAction.fadeAlpha(to: 0.1, duration: fadeOutDuration),SKAction.fadeAlpha(to: 0.9, duration: fadeInDuration)]))
        player.component(ofType: SpriteComponent.self)?.node.run(sequence, withKey: "fadeSequence")
    }
    func updateScoreLabel() {
        
        let playerScore = player.component(ofType: ScoreComponent.self)?.points
        label.text = "Score:" + "\(playerScore!)"
    }
    
    @objc func swipeLeft(sender: UIGestureRecognizer){
        
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
    
    @objc func swipeRight(sender: UIGestureRecognizer){
        
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
    
    @objc func swipeUp(sender: UIGestureRecognizer){
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
    
    @objc func swipeDown(sender: UIGestureRecognizer){
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
    
    func endGame(){
        // restart the game
        let scene = SceneLevel_1(size: CGSize(width: (self.view?.frame.width)!, height: (self.view?.frame.height)!))
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view!.presentScene(scene)
    }
}
