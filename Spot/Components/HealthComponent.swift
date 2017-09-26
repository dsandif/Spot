//
//  HealthComponent.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit

class HealthComponent: GKComponent {
    var health = 0;
    
    init(health:Int) {
        super.init()
        self.health = health;
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func UpdateHealth(amount:Int){
        self.health += amount
    }
}
