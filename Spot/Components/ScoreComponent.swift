//
//  ScoreComponent.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit

class ScoreComponent: GKComponent {
    var points:Int
    
    init(points:Points){
        self.points = points.rawValue
        super.init()
        
    }
    
    func UpdatePoints(amount:Points){
        self.points += amount.rawValue
    }
    
    func CollectPrize(prize:Prize){
        //if the prize is health then get the current health component and add the prize amount to the players health
        
        //if the prize is points then get the current score component and add it to the players point total by calling self.UpdatePoints
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
