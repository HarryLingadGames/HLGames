//
//  ActionHelper.swift
//  AlphabetWar
//
//  Created by Harry on 12/3/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion
import GameplayKit


class ActionHelper{
    
    static func fireEnemy(letterButtons: [AWLettersSKSN], letter: [Letter], touches: Set<UITouch>, gameScene: GameScene, completion: @escaping(LetterType)->() ){
        let touch = touches.first!
        
        for letterButton in letterButtons{
            if letterButton.contains(touch.location(in: gameScene)) {
                completion(letterButton.letter.type ?? LetterType.a)
                return
            }
        }
    }
    
    static func adjustPropertyOfPressedButton(letterButtons: [AWLettersSKSN], touches: Set<UITouch>, gameScene: GameScene){
        let touch = touches.first!
        
        for letterButton in letterButtons{
            if letterButton.contains(touch.location(in: gameScene)) {
                letterButton.size = CGSize(width: letterButton.size.width + 4, height: letterButton.size.height + 4)
                letterButton.position = CGPoint(x: letterButton.position.x - 2, y: letterButton.position.y - 2)
                return
            }
        }
    }
    
    static func adjustPropertyOfReleasedButton(letterButtons: [AWLettersSKSN], touches: Set<UITouch>, gameScene: GameScene){
        let touch = touches.first!
        
        for letterButton in letterButtons{
            if letterButton.contains(touch.location(in: gameScene)) {
                letterButton.size = CGSize(width: letterButton.size.width - 4, height: letterButton.size.height - 4)
                letterButton.position = CGPoint(x: letterButton.position.x + 2, y: letterButton.position.y + 2)
                return
            }
        }
    }
}
