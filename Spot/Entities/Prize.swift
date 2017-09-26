//
//  Prize.swift
//  Spot
//
//  Created by Darien Sandifer on 9/25/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import GameplayKit


enum PrizeType {
    case Points
    case ExtraLives
}


class Prize: GKEntity {
    var prizeType:PrizeType? = nil;
    var extraLives: Int = 0;
    var extraPoints:Int = 0;
    
    init(amount:Int,prizeType:PrizeType) {
        super.init()
        AddPrize(amount: amount, prizeType: prizeType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func AddPrize(amount:Int, prizeType:PrizeType){
    
        switch prizeType {
            case .ExtraLives:
                self.extraLives += amount
                break;
            case .Points:
                self.extraPoints += amount
                break;
        }
    }
    
}
