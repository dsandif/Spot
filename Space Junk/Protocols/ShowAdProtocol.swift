//
//  ShowAdProtocol.swift
//  Space Junk
//
//  Created by Darien Sandifer on 12/31/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import Foundation


protocol TryAgainDelegate {
    func tryAgain()
}

protocol GameEndDelegate {
    func GameEnded(finalScore:Int)
}
