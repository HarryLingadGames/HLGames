//
//  TorpedoNode.swift
//  AlphabetWar
//
//  Created by Harry on 12/13/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class TorpedoNode: SKSpriteNode{
    
    var actionArray = [SKAction]()
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(imageNamed: String, gameScene: GameScene){
        super.init(texture: SKTexture(imageNamed: imageNamed), color: UIColor.white, size: CGSize(width: 27, height: 37))
        self.position(gameScene: gameScene)
        self.actions(gameScene: gameScene)
        self.categories(gameScene: gameScene)
        gameScene.addChild(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func position(gameScene: GameScene){
        self.position = CGPoint(x: (gameScene.playComponents.targetNode?.position.x)!, y: gameScene.playComponents.letterButtons.size.height)
        self.position.y += 5
        
    }
    
    private func actions(gameScene: GameScene){
        let animationDuration:TimeInterval = 0.3
        actionArray.append(SKAction.move(to: CGPoint(x: (gameScene.playComponents.targetNode?.position.x)!, y: gameScene.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.hide())
        
    }
    
    private func categories(gameScene: GameScene){
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.isDynamic = true

        self.physicsBody?.categoryBitMask = gameScene.playComponents.photonTorpedoCategory
        self.physicsBody?.contactTestBitMask = gameScene.playComponents.alienCategory
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
}
