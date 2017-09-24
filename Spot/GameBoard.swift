//
//  GameBoard.swift
//  Spot
//
//  Created by Darien Sandifer on 9/23/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation
import SpriteKit

class GameBoard {
    var numSpaces = 9
    var board: [Tile] = []
    private var numRows = 3;
    private var numCols = 3
    init() {
        
        LoadBoardPieces();
    }
    
    func LoadBoardPieces() {

        
        for idx in 0...(numSpaces-1) {

            var moveSpace = Tile()
            board.append(moveSpace)
            
            if idx == 1 {
                xVal = 0
                yVal = 0
            }else{
                
            }
            
            moveSpace.node.position = CGPoint(x:xVal,y:yVal)
        }
    }
    
    
}
