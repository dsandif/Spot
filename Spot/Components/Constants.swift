//
//  Constants.swift
//  Spot
//
//  Created by Darien Sandifer on 12/19/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation

enum BitMasks:UInt32 {
    case All
    case PlayerCategory
    case OrbCategory
    case TileCategory
    case BoltCategory
    case LaserCategory
    case StarCategory
    case BorderCategory
}

enum Points:Int {
    case StartingPoints = 0
    case MissedOrb = 5
    case MovementPoint = 10
    case BoltPoints = 25
    case LaserPoints = 50
    case StarPoints = 100
}



extension Float{
    func roundToTens() -> Int{
        return 10 * Int(Darwin.roundf(self / 10.0))
    }
    
    func roundToHundreds() -> Int{
        return 100 * Int(Darwin.roundf(self / 100.0))
    }
}

extension Double{
    func roundToTens() -> Int{
        return 10 * Int(Darwin.round(self / 10.0))
    }
    
    func roundToHundreds() -> Int{
        return 100 * Int(Darwin.round(self / 100.0))
    }
}
