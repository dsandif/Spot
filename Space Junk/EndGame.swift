//
//  EndGame.swift
//  Spot
//
//  Created by Darien Sandifer on 12/29/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit
import GoogleMobileAds

class EndGame:SKScene{
    
    var tryAgainDelegate: TryAgainDelegate?
    var finalScore:Int = 0
    let newGameButton = SKSpriteNode(imageNamed: "newgame")
    let tryAgainButton = SKSpriteNode(imageNamed: "tryagain")

    override func didMove(to view: SKView) {
        // Set the scale mode to scale to fit the window
        self.scaleMode = .resizeFill
        
        //add Game over label
        let label = SKSpriteNode(imageNamed: "gameOver")
        label.position = CGPoint(
            x: size.width/2,
            y: size.height - size.height/3
        )
        
        addChild(label)
        
        //add high score label
        if getHighScore() > finalScore {
            let bestScoreLabel = SKLabelNode(text:"Best: \(getHighScore())")
            bestScoreLabel.fontSize = 35.0
            bestScoreLabel.horizontalAlignmentMode = .center
            bestScoreLabel.verticalAlignmentMode = .center
            bestScoreLabel.position = CGPoint(
                x: label.position.x,
                y: label.position.y - 85
                
            )
            
            addChild(bestScoreLabel)
            
            let scoreLabel = SKLabelNode(text:"Final Score: \(finalScore)")
            scoreLabel.fontSize = 35.0
            scoreLabel.horizontalAlignmentMode = .center
            scoreLabel.verticalAlignmentMode = .center
            scoreLabel.position = CGPoint(
                x: bestScoreLabel.position.x,
                y: bestScoreLabel.position.y - 45
                
            )
            addChild(scoreLabel)
            
            //add new game button
            
            newGameButton.position = CGPoint(
                x: scoreLabel.position.x,
                y: scoreLabel.position.y - 70
            )
            newGameButton.name = "newGameButton"
        }else if finalScore > 0{
            let text = finalScore > 0 ? "New High:" : "Final Score:"
            let scoreLabel = SKLabelNode(text: "\(text) \(finalScore)")
            
            scoreLabel.fontSize = 35.0
            scoreLabel.horizontalAlignmentMode = .center
            scoreLabel.verticalAlignmentMode = .center
            scoreLabel.position = CGPoint(
                x: label.position.x,
                y: label.position.y - 85
                
            )
            addChild(scoreLabel)
            
            saveHighScore()
            
            //add new game button
            
            newGameButton.position = CGPoint(
                x: scoreLabel.position.x,
                y: scoreLabel.position.y - 55
            )
            newGameButton.name = "newGameButton"
        }
        

        
        let hoverUpAction = SKAction.moveBy(x:0, y: 15, duration: 0.8)
        let hoverDownAction = SKAction.moveBy(x:0, y: -15, duration: 0.8)
        let floatingSequence = SKAction.sequence([hoverDownAction,hoverUpAction])
        let repeatedAction = SKAction.repeatForever(floatingSequence)
        
        newGameButton.run(repeatedAction)
        addChild(newGameButton)
        
        tryAgainButton.position = CGPoint(
            x: newGameButton.position.x,
            y: newGameButton.position.y - 50
        )
        tryAgainButton.name = "tryAgainButton"
        
        addChild(tryAgainButton)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.nodes(at: positionInScene).first
        
        if touchedNode?.name == newGameButton.name{
            newGame()
            
        }else if touchedNode?.name == tryAgainButton.name {
            tryAgainDelegate?.tryAgain()
        }
    }
    func getHighScore() -> Int {
        let userDefults = UserDefaults.standard //returns shared defaults object.

        if let highScore = userDefults.value(forKey: "highScore") { //Returns the integer value associated with the specified key.
            return highScore as! Int
            
        } else {
            return 0
        }
        
        
    }
    func saveHighScore() {
        let userDefults = UserDefaults.standard //returns shared defaults object.
        userDefults.set(finalScore, forKey: "highScore") //Sets the value of the specified default key to the specified integer value.

    }
    func newGame(){
        //restart the game
        let scene = SceneLevel_1(size: CGSize(width: (self.view?.frame.width)!, height: (self.view?.frame.height)!))
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: 2))

    }
    
}

