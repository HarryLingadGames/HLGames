//
//  AWGameStandByComponents.swift
//  AlphabetWar
//
//  Created by Harry on 12/6/20.
//  Copyright © 2020 Harry. All rights reserved.
//


import SpriteKit
import GameplayKit
import CoreMotion

class AWGameStandByComponents: NSObject{
    var playButton: SKSpriteNode!
    var gameLogo: SKSpriteNode!
    
    override init() {
        super.init()
    }
    
    init(gameScene: GameScene){
        gameLogo = SKSpriteNode(imageNamed: "logo")
        let heightDivided = gameScene.size.height / 8
        gameLogo.position = CGPoint(x: gameScene.size.width / 2, y: heightDivided * 5)
//        gameLogo.size = CGSize(width: 86 * 2, height: 90 * 2)
        gameLogo.size = CGSize(width: 328, height: 193)
        
        gameScene.addChild(gameLogo)
        
        playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: gameScene.size.width / 2, y: heightDivided * 2.5)
        playButton.size = CGSize(width: 100, height: 120)
        gameScene.addChild(playButton)
    }
    
    func removeComponents(gameScene: GameScene){
        playButton.removeFromParent()
        gameLogo.removeFromParent()
    }
    
    
}
