//
//  Card.swift
//  Concentration
//
//  Created by AHMED GAMAL  on 3/15/19.
//  Copyright © 2019 AHMED GAMAL . All rights reserved.
//

import Foundation
struct Card : Hashable{
    var hashValue : Int{return identifier}
    static func == (lhs : Card , rhs : Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    private var identifier : Int
    var isFacedUp = false
    var isMatched = false
    var FlippedOnce = false
    private  static var uniqueIdentifierFactor = 0
    
    private static func getUniqueIdentifier() -> Int{
        uniqueIdentifierFactor += 1
        return uniqueIdentifierFactor
        
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
}
