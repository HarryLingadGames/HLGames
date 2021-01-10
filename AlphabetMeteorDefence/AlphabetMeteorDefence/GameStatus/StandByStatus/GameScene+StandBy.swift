//
//  GameScene+StandBy.swift
//  AlphabetWar
//
//  Created by Harry on 12/6/20.
//  Copyright © 2020 Harry. All rights reserved.
//


import SpriteKit
import GameplayKit
import CoreMotion

extension GameScene{
    
    func initializeStandByComponents(){
        standByComponents = AWGameStandByComponents(gameScene: self)
        
    }
}

