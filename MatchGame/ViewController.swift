//
//  ViewController.swift
//  MatchGame
//
//  Created by iOSDev on 4/10/19.
//  Copyright © 2019 iOSDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movesMadeLbl: UILabel!
    @IBOutlet weak var movesLeftLbl: UILabel!
    var gameModel = GameModel()
    var flippedCards: (Int?, Int?)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func flipCard(_ sender: UIButton) {
        let btnNumberInt = sender.tag
        let emoji = gameModel.flipCard(cardNumber: btnNumberInt)
        
        if (flippedCards.0 == nil) {
            flippedCards.0 = btnNumberInt
        } else if (flippedCards.0 == sender.tag) {
            return
        } else if (flippedCards.1 == nil) {
            flippedCards.1 = btnNumberInt
        } else {
            return
        }
        
        sender.setTitle(emoji, for: .normal)
        sender.setBackgroundImage(UIImage(), for: .normal)
        sender.setTitleColor(UIColor.black, for: .normal)
        
        // Make button not flippable
        sender.isUserInteractionEnabled = false
        
        // Check if there is a match
        if (flippedCards.0 != nil && flippedCards.1 != nil) {
            // Need to convert my optional int tuple
            let cards = (flippedCards.0!, flippedCards.1!)
            
            let match = gameModel.checkMatch(flippedCards: cards)
            if (!match) {
                unflipCards(first: cards.0, second: cards.1)
            }
            
            // Unset flippedCards
            flippedCards.0 = nil
            flippedCards.1 = nil
        }
    }
    
    func unflipCards(first: Int, second: Int) {
        guard let button1 = self.view.viewWithTag(first) as? UIButton else {
            return
        }
        
        guard let button2 = self.view.viewWithTag(second) as? UIButton else {
            return
        }
        
        button1.setTitle("", for: .normal)
        button2.setTitle("", for: .normal)
        
        button1.setBackgroundImage(UIImage(named: "images.jpeg"), for: .normal)
        button2.setBackgroundImage(UIImage(named: "images.jpeg"), for: .normal)
        
        button1.isUserInteractionEnabled = true
        button2.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

