//
//  EnemyLetter.swift
//  AlphabetWar
//
//  Created by Harry on 12/4/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class EnemyLetterNode: SKSpriteNode{
    
    var type: LetterType?
    var actionArray = [SKAction]()
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(gameScene: GameScene, type: LetterType){
        super.init(texture: SKTexture(imageNamed: type.rawValue), color: UIColor.white, size: CGSize(width: 50, height: 50))
        self.type = type
        self.position(gameScene: gameScene)
        self.categories(gameScene: gameScene)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func position(gameScene: GameScene){
        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: Int(gameScene.size.width))
        let position = CGFloat(randomAlienPosition.nextInt())
        self.position = CGPoint(x: position, y: gameScene.frame.size.height + self.size.height)
        
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -10), duration: GameDimension.ENEMYLETTER_SPEED_OF_FALLING))
        actionArray.append(SKAction.removeFromParent())
    }
    
    private func categories(gameScene: GameScene){
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        
        self.physicsBody?.categoryBitMask = gameScene.playComponents.alienCategory
        self.physicsBody?.contactTestBitMask = gameScene.playComponents.photonTorpedoCategory
        self.physicsBody?.collisionBitMask = 0
    }
}
