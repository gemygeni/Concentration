//
//  ViewController.swift
//  Concentration
//
//  Created by AHMED GAMAL  on 2/20/19.
//  Copyright © 2019 AHMED GAMAL . All rights reserved.
//

import UIKit

class concentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards : numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int{
        
        return (visibleCardButtons.count + 1)/2
    }
    
    private(set)  var flipCount = 0
    {
        didSet {
            updateCountLabel()
            
        }
    }
    
    private func updateCountLabel (){
        let attributes : [NSAttributedString.Key : Any]? =  [.strokeWidth : -1.0 , .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ]
        let attributedString = NSAttributedString(string: traitCollection.verticalSizeClass ==
            .compact ? "Flips\n \(flipCount)" : "Flips : \(flipCount)" , attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateCountLabel()
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            flipCountLabel.layer.cornerRadius = 3.0
            flipCountLabel.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            flipCountLabel.layer.borderWidth = 2.0
            updateCountLabel()
            
        }
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!{
        didSet{
            for button in cardButtons {
                button.layer.cornerRadius = 12.0
                button.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                button.layer.borderWidth = 4.0
                
            }
        }
    }
    
    private var visibleCardButtons : [UIButton]!{
        return cardButtons?.filter {!$0.superview!.isHidden}
    }
   
  
    @IBAction func touchcard(_ sender : UIButton){
        flipCount += 1
        if let CardNumber = visibleCardButtons.index(where:{$0 == sender}) {
            
            game.chooseCard(at: CardNumber)
            updateViewFromModel()
           
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    //metod to change the View due to changes in Model
    private func updateViewFromModel(){
        //loop over buttons array
        if visibleCardButtons != nil{
        for index in visibleCardButtons.indices{
            
            let button = visibleCardButtons [index]
            let card   = game.cards [index]
            if card.isFacedUp{//case the card faced up
                button.setTitle(emoji(for: card) , for: UIControl.State.normal)
                button.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {//case that card faced down
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 1, green: 0.5494377613, blue: 0, alpha: 0) :  #colorLiteral(red: 1, green: 0.5494377613, blue: 0, alpha: 1)
            }
        }
      }
    }
    
    var theme : String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
   private var emojiChoices = "🎃👻👺👽💀👀🌚🔱👹☠️"
   private var emoji = [Card : String]()
    
    private func emoji (for card : Card) -> String{
        if emoji[card] == nil ,emojiChoices.count > 0 {
            //generate random int number from zero to count of emojies in emojichoise array
                     let randomIndex = emojiChoices.count.arc4random
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex , offsetBy: randomIndex )
            emoji[card] = String (emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? ""
    }
    
//    another method without themes
//    var emojiChoices = ["🎃" ,"👻", "😀", "🐶", "🍎", "👹", "☠️",
//                        "🍄", "🧲", "🦍", "🚒", "✈️", "🚲", "🐪", "🦁",
//                        "😂", "🌶", "♣️", "⏰", "⛴", "⚓️", "🏠", "🚙",
//                        "🎧", "🥊", "🏓", "🥎", "🍔", "🍉", "🍇", "💎",
//                        "⚽️", "🏀", "❤️", "☎️"]
//
//    //dictionary of int(card identifier) & string(emoji)
//    var emoji = [Card : String]()
//
//    //function to get random emoji
//    func emoji( for card: Card) -> String {
//
//        if emojiChoices.count > 0 //because i remove emojies from this array
//            , emoji [card] == nil //make sure that card has no emoji yet
//        {
//            //generate random int number from zero to count of emojies in emojichoise array
//            let randomIndex = emojiChoices.count.arc4random
//
//            //fill dictionary so that give card identifier a arandom  (emoji moved from emojiChoices)
//            emoji[card] = emojiChoices.remove(at:randomIndex )
//
//        }
//        // return emoji of card identifier or "?" if it is nill
//        return emoji [card] ?? "?"
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    }
    
   
//extension to generate random number for any integer
extension (Int){
    var arc4random : Int{
        if self > 0 {
            return Int (arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int (arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}








