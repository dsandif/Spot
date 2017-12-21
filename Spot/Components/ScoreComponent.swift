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
    
    func CollectPrize(amount:Points){
        UpdatePoints(amount: amount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
