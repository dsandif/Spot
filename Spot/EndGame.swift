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

class EndGame:SKScene{
    var finalScore:Int = 0
    let newGameButton = SKSpriteNode(imageNamed: "newgame")
    override func didMove(to view: SKView) {
        // Set the scale mode to scale to fit the window
        self.scaleMode = .resizeFill
        
        //add Game over label
        let label = SKSpriteNode(imageNamed: "gameOver")
        label.position = CGPoint(
            x: size.width/2,
            y: size.height - size.height/3
        )
        
        //add game over label
        addChild(label)
        
        let scoreLabel = SKLabelNode(text:"FINAL SCORE: \(finalScore)")
        scoreLabel.fontSize = 35.0
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(
            x: label.position.x,
            y: label.position.y - 70
        
        )
        
        addChild(scoreLabel)
        
        //add new game
        
        newGameButton.position = CGPoint(
            x: scoreLabel.position.x,
            y: scoreLabel.position.y - 70
        )
        newGameButton.name = "newGameButton"
        
        let hoverUpAction = SKAction.moveBy(x:0, y: 15, duration: 0.8)
        let hoverDownAction = SKAction.moveBy(x:0, y: -15, duration: 0.8)
        let floatingSequence = SKAction.sequence([hoverDownAction,hoverUpAction])
        let repeatedAction = SKAction.repeatForever(floatingSequence)
        newGameButton.run(repeatedAction)
        
        addChild(newGameButton)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.nodes(at: positionInScene).first
        
        if touchedNode?.name == newGameButton.name{
            newGame()
        }
    }
    
    func newGame(){
        //restart the game
        let scene = SceneLevel_1(size: CGSize(width: (self.view?.frame.width)!, height: (self.view?.frame.height)!))
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: 2))

    }
}

