//
//  ValueComponent.swift
//  Spot
//
//  Created by Darien Sandifer on 12/20/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit

class ValueComponent: GKComponent {
    var value:Points = Points.StartingPoints
    
    init(points:Points){
        super.init()
        self.value = points
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
