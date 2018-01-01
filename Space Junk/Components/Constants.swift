//
//  Constants.swift
//  Spot
//
//  Created by Darien Sandifer on 12/19/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import SpriteKit

enum BitMasks:UInt32 {
    case All
    case PlayerCategory
    case OrbCategory
    case TileCategory
    case BoltCategory
    case LaserCategory
    case StarCategory
    case BorderCategory
    case ExtraLifeCategory
}

enum Points:Int {
    case StartingPoints = 0
    case MissedOrb = 5
    case MovementPoint = 10
    case BoltPoints = 25
    case LaserPoints = 50
    case StarPoints = 100
}

//all nodes have equal height/width
enum NodeSize: CGFloat  {
    case Small = 8.0
    case Medium = 15.0
    case Large = 50.0
    
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

func degToRad(deg : Double) -> Double {
    return deg / 180 * .pi
}
