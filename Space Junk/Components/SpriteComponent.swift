//
//  SpriteComponent.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//
import Foundation
import GameplayKit

class SpriteComponent: GKComponent {
  var node: SKSpriteNode
    
  init(texture: SKTexture) {
    node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
    super.init()
  }
    
  override func update(deltaTime seconds: TimeInterval) {
        
  }
    
  required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
  }
}
