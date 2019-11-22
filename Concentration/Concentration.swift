//
//  Concentration.swift
//  Concentration
//
//  Created by AHMED GAMAL  on 3/8/19.
//  Copyright © 2019 AHMED GAMAL . All rights reserved.
//

import Foundation
struct Concentration{
    private(set) var cards = [Card]()
    private(set)  var score = 0
    
    private var indexOfOneAndOnlyCardFaceUP : Int? {
        //var getter
        get {
            return cards.indices.filter {cards[$0].isFacedUp}.oneAndOnly
            //            var foundIndex : Int?
            //            //loop over cards array
            //            for index in cards.indices{
            //
            //                if cards[index].isFacedUp {
            //                    if  foundIndex == nil{ //we have no card yet, this is the first one
            //
            //                        foundIndex = index // indexOfOneAndOnlyCardFaceUP = index of this card
            //
            //                    } else{
            //                return nil //there is other card faced up and its index is indexOfOneAndOnlyCardFaceUP
            //                    }
            //                }
            //            }
            //            return foundIndex
        }
        //var setter
        set {
            //loop over cards array
            for index in cards.indices{
                //traverse cards array and if index of this card = newValue(indexOfOneAndOnlyCardFaceUP) make this card facedUp, else for other cards make it false(faced down)
                cards [index].isFacedUp = (index == newValue)
                
                
                
                if  cards [index].isFacedUp {
                    if cards[index].FlippedOnce && !cards[index].isMatched{
                        
                        score -= 1
                    }
                }
            }
        }
    }
    //intialising concentration struct
    init (numberOfPairsOfCards : Int) {
        assert(numberOfPairsOfCards > 0 , "concentration.init (\(numberOfPairsOfCards)) : you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card , card]
        }
        cards.shuffle()
    }
    
    // method to choose a card
    mutating func chooseCard(at index : Int)  {
        assert(cards.indices.contains(index) , "consentration.choosecard (at \(index)), choosen index not in cards")
        if !cards [index].isMatched {
            
            //case of one card facedup and user pressed another
            if let matchIndex = indexOfOneAndOnlyCardFaceUP //getter of indexOfOneAndOnlyCardFaceUP
                , matchIndex != index{
                
                
                if cards[matchIndex] == cards [index]{
                    
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFacedUp = true
                
                //test
                if  cards [index].isFacedUp {
                    if cards[index].FlippedOnce && !cards[index].isMatched{
                        
                        score -= 1
                    }
                }
            }
                
                // case of either no cards or ,tow cards are faced up
            else {
                indexOfOneAndOnlyCardFaceUP = index //setter of indexOfOneAndOnlyCardFaceUP
                
            }
        }
        cards [index].FlippedOnce = true
    }
    
  
}
//Mark : extension to collection
//extension to add property to any collection that return first one and only one element in this collection
extension Collection {
    
    var oneAndOnly : Element? {
        
        return count == 1 ? first : nil
    }
}
/* note that array.Index is a type alias to be Int
 and String.Element is a type alias to be CH
 */
