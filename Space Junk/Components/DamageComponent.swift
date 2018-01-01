//
//  DamageComponent.swift
//  Spot
//
//  Created by Darien Sandifer on 9/26/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit

class DamageComponent: GKComponent {
    var power:Int = 0
    
    init(power:Int){
        super.init()
        self.power = power;
    }
    
    func damaging(target:GKEntity){
        let targetHealth = target.component(ofType: HealthComponent.self);
        targetHealth?.UpdateHealth(amount: -self.power);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
