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
    
    init(points:Int){
        self.points = points
        super.init()
        
    }
    
    func UpdatePoints(amount:Int){
        self.points += amount
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
