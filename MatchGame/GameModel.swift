//
//  GameModel.swift
//  MatchGame
//
//  Created by iOSDev on 4/30/19.
//  Copyright © 2019 iOSDev. All rights reserved.
//

import Foundation

// I'm running Swift 4.1, so I need these extension methods
/* Credit: https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift/24029847 */

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

struct Node {
    var emoji: String
    var matched: Bool
    
    init(new_emoji: String) {
        emoji = new_emoji
        matched = false
    }
}

class GameModel {
    let emojiArr = ["🍎", "🥦", "🥓", "🍞", "🍓", "🧀", "🌮", "🍪", "🍰", "🍿"]
    
    var gameBoard = [[Node]]()
    var movesLeft: Int
    var matchesMade: Int

    init() {
        movesLeft = 40
        matchesMade = 0
        
        // Initialize the emoji array
        var emojiShuffled = [String]()
        for emoji in emojiArr {
            emojiShuffled.append(emoji)
            emojiShuffled.append(emoji)
        }
        
        // Shuffle these elements using extension methods
        emojiShuffled.shuffle()
        
        // Initialize the game board
        var count = 0
        var tempArr = [Node]()
        while (count < 20) {
            let tempNode = Node(new_emoji: emojiShuffled[count])
            if (count % 4 == 3 && count != 0) {
                tempArr.append(tempNode)
                gameBoard.append(tempArr)
                tempArr.removeAll()
            } else {
                tempArr.append(tempNode)
            }
            count += 1
        }
    }
    
    func checkMatch(flippedCards: (Int, Int)) -> Bool {
        var first = getNode(index: flippedCards.0)
        var second = getNode(index: flippedCards.1)
        
        let firstEmoji = first.emoji
        let secondEmoji = second.emoji
        
        if (firstEmoji != secondEmoji) {
            return false
        } else {
            first.matched = true
            second.matched = true
            matchesMade += 1
            return true
        }
    }
    
    func flipCard(cardNumber: Int) -> String {
        let card = getNode(index: cardNumber)
        movesLeft -= 1
        return card.emoji
    }
    
    func checkResult() -> Bool {
        for i in gameBoard {
            for j in i {
                if (!j.matched) {
                    return false
                }
            }
        }
        
        // All nodes are matched
        return true
    }
    
    func getNode(index: Int) -> Node {
        let row = index / 4
        let col = index % 4
        return gameBoard[row][col]
    }
    
    func getMatchesMade() -> Int {
        return matchesMade
    }
    
    func getMovesLeft() -> Int {
        return movesLeft
    }
}
