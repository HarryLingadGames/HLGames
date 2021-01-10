//
//  GameScene+Play.swift
//  AlphabetWar
//
//  Created by Harry on 12/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

extension GameScene: GameViewControllerProtocol{

    func initializePlayComponents() {
        playComponents = AWGamePlayComponents(gameScene: self)
    }
    
    @objc func addEnemyLetter () {
        
        playComponents.enemyLetterNames = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: playComponents.enemyLetterNames) as! [LetterType]
        
        let letter = EnemyLetterNode(gameScene: self, type: playComponents.enemyLetterNames[0])
        self.addChild(letter)
        
        enemyCounter = enemyCounter + 1
        
        playComponents.activeEnemyLetter.append(letter)
        
        if !playComponents.targetNode!.hasTarget{
            playComponents.targetNode?.setTarget(target: letter)
        }
        
        letter.run(SKAction.sequence(letter.actionArray))
    }
    
    func fireTorpedo(type: LetterType) {
        if playComponents.targetNode.hasTarget && playComponents.targetNode?.targetType() == type{
            
            self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
            let torpedoNode = TorpedoNode(imageNamed: "torpedo", gameScene: self)
            
            torpedoNode.run(SKAction.sequence(torpedoNode.actionArray))
        }
    }
    
    
    func torpedoDidCollideWithAlien (torpedoNode:SKSpriteNode, enemyLetter:SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "TestSpark")!
        explosion.position = enemyLetter.position
        
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpedoNode.removeFromParent()
        enemyLetter.removeFromParent()
        
        print("activeEnemyLetter : \(self.playComponents.activeEnemyLetter.count)")
        
        if self.playComponents.activeEnemyLetter.count > 0{
            let testIndex = self.playComponents.activeEnemyLetter.firstIndex(of: playComponents.targetNode.targetLetter ?? EnemyLetterNode())
            self.playComponents.activeEnemyLetter.remove(at: testIndex ?? 0)
            if self.playComponents.activeEnemyLetter.count > 0{
                self.playComponents.targetNode.setTarget(target:  self.playComponents.activeEnemyLetter[0])
            }else{
                self.playComponents.targetNode.removeTarget()
            }
        }
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        playComponents.score += 1
    }
    
    func enemyLetterExplode(){
        if let explosion = SKEmitterNode(fileNamed: "base_explosion"){
            explosion.position = (playComponents.targetNode?.position)!
            self.addChild(explosion)
            
            self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
            playComponents.targetNode?.targetLetter?.removeFromParent()
            
            
            if self.playComponents.activeEnemyLetter.count > 0, let targetLetter = playComponents.targetNode.targetLetter {
                let testIndex = self.playComponents.activeEnemyLetter.firstIndex(of: targetLetter)
                self.playComponents.activeEnemyLetter.remove(at: testIndex ?? 0)
                self.playComponents.targetNode.setTarget(target: self.playComponents.activeEnemyLetter[0])
            }
            
            self.run(SKAction.wait(forDuration: 2)) {
                explosion.removeFromParent()
            }
        }
    }
    
    func playButtonExplode(){
        if let explosion = SKEmitterNode(fileNamed: "Explosion"){
            explosion.position = (standByComponents.gameLogo.position)
            self.addChild(explosion)
            
            self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
            self.run(SKAction.wait(forDuration: 1)) {
                explosion.removeFromParent()
                self.playComponents.showAllComponents(scene: self)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
           
           var firstBody:SKPhysicsBody
           var secondBody:SKPhysicsBody
           
           if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
               firstBody = contact.bodyA
               secondBody = contact.bodyB
           }else{
               firstBody = contact.bodyB
               secondBody = contact.bodyA
           }
           
           if (firstBody.categoryBitMask & playComponents.photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & playComponents.alienCategory) != 0 {
               torpedoDidCollideWithAlien(torpedoNode: firstBody.node as! SKSpriteNode, enemyLetter: secondBody.node as! SKSpriteNode)
           }
       }
}
