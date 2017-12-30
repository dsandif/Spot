//
//  Prize.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit


enum PrizeType: UInt32 {
    case ExtraLives
    case Points
    
    static func randomType() -> PrizeType {
        
        // pick and return a new value, use 2 because there are 2 types
        let randomValue = arc4random_uniform(UInt32(2))
        return PrizeType(rawValue: randomValue)!
    }
}


enum PrizeImage: String{
    case EnemyOrb = "spaceMeteors_001"
    case SilverBolt = "bolt_silver"
    case BronzeBolt = "bolt_bronze"
    case GoldBolt  = "bolt_gold"
    case BlueLaserSkinny = "laserBlue09"
    case BlueLaserCircle = "laserBlue08"
    case BlueLaserReg = "laserBlue10"
    case GreenLaserSkinny = "laserGreen15"
    case GreenLaserCircle = "laserGreen14"
    case GreenLaserReg = "laserGreen16"
    case RedLaserSkinny = "laserRed09"
    case RedLaserCircle = "laserRed08"
    case RedLaserReg = "laserRed10"
    case ExtraLifeImage = "Rocket"
    
    static func random() -> (SpriteComponent, PrizeImage) {
        //make sure all names are in the imagenames array
        let imageNames:[PrizeImage] = [.EnemyOrb,.SilverBolt,.BronzeBolt,.GoldBolt,.BlueLaserCircle,.BlueLaserSkinny,.BlueLaserReg,.GreenLaserCircle,.GreenLaserSkinny,.GreenLaserReg,.RedLaserCircle,.RedLaserSkinny,.RedLaserReg]
        //get a random number from 1 - count
        let index = Int(arc4random_uniform(UInt32(imageNames.count)))
        
        //get the image file name
        let image = imageNames[index].rawValue
        //add the prizes SpriteComponent
        let texture = SKTexture(imageNamed:image)
        let spriteComponent = SpriteComponent(texture: texture)
        spriteComponent.node.size = CGSize(width:NodeSize.Large.rawValue,height:NodeSize.Large.rawValue)
        //create and return an SKtexture and the associated prize enum value
        return (spriteComponent,imageNames[index])
    }
    
    static func getImage(imageName: PrizeImage) -> SpriteComponent{
        let texture = SKTexture(imageNamed:imageName.rawValue)
        return SpriteComponent(texture: texture)
    }
}

class Prize: GKEntity {
    var prizeType:PrizeType? = nil;
    var pHeight = 50;
    var pWidth = 50;
    
    override init() {
        super.init()
        self.prizeType = PrizeType.randomType()
        
        switch prizeType {
        case .Points?:
                //pick a random image name
                let image = PrizeImage.random()
                let spriteComponent = image.0
                let imageType = image.1
                let prizeNode = spriteComponent.node
                prizeNode.physicsBody = SKPhysicsBody(circleOfRadius: prizeNode.size.width/2)
                prizeNode.physicsBody?.contactTestBitMask = BitMasks.PlayerCategory.rawValue
                prizeNode.physicsBody?.isDynamic = true
                prizeNode.physicsBody?.affectedByGravity = false
                
                //add bitmask
                if imageType.rawValue.contains("bolt"){
                    prizeNode.physicsBody?.categoryBitMask = BitMasks.LaserCategory.rawValue
                    
                    //add prize value
                    let valueComponent = ValueComponent(points: .BoltPoints)
                    addComponent(valueComponent)
                }
                else if imageType.rawValue.contains("laser"){
                    prizeNode.physicsBody?.categoryBitMask = BitMasks.BoltCategory.rawValue
                    
                    //addprize value
                    let valueComponent = ValueComponent(points: .LaserPoints)
                    addComponent(valueComponent)
                }else if imageType.rawValue.contains("spaceMeteors"){
                    prizeNode.physicsBody?.categoryBitMask = BitMasks.OrbCategory.rawValue
                    
                    //no prize value necessary
                }
                
                //create the rotatig action and ad the sprite component
                runAction(prizeNode: prizeNode)
                addComponent(spriteComponent)
                

            
            
        case .ExtraLives?:
                let spriteComponent = PrizeImage.getImage(imageName: PrizeImage.ExtraLifeImage)
                spriteComponent.node.size = CGSize(width:NodeSize.Large.rawValue,height:NodeSize.Large.rawValue)
                let prizeNode = spriteComponent.node
                prizeNode.physicsBody = SKPhysicsBody(circleOfRadius: prizeNode.size.width/2)
                prizeNode.physicsBody?.categoryBitMask = BitMasks.ExtraLifeCategory.rawValue
                prizeNode.physicsBody?.contactTestBitMask = BitMasks.PlayerCategory.rawValue
                prizeNode.physicsBody?.isDynamic = true
                prizeNode.physicsBody?.affectedByGravity = false
                runAction(prizeNode: prizeNode)
                addComponent(spriteComponent)
            
            default:
                break
        }
        
        

        

    }
    
    func runAction(prizeNode:SKSpriteNode){
        
        //setup rotation action
        let oneRevolution:SKAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1)
        let repeatRotation:SKAction = SKAction.repeatForever(oneRevolution)
        prizeNode.run(repeatRotation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
