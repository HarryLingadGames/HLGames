//
//  GameScene.swift
//  AlphabetMeteorDefence
//
//  Created by Harry Lingad on 1/10/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

protocol KeyBoardProtocol {
    func showKeyboard()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var xAcceleration:CGFloat = 0
    var playComponents: AWGamePlayComponents!
    var standByComponents: AWGameStandByComponents!
    
    var gameStatus: GameStatus = GameStatus.StandBy
    var enemyCounter: Int = 0

    var keyBoardDelegate: KeyBoardProtocol?

    var gameViewController: GameViewController?
    
    //MARK : INITIALIZE
    override func didMove(to view: SKView) {
        
        switch gameStatus {
        case GameStatus.StandBy:
            initializeStandByComponents()
             initializePlayComponents()
            
            break
        case GameStatus.Play:
            break
        case GameStatus.GameOver:
            print("GameOver")
            break
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch gameStatus {
        case GameStatus.StandBy:
            break
        case GameStatus.Play:
            if let targetLetter = playComponents.targetNode.targetLetter{
                if ((targetLetter.position.y) - targetLetter.size.height / 2) <= (playComponents.letterButtons.size.height){
                    enemyLetterExplode()
                }
            }
            
            if playComponents.activeEnemyLetter.count > 0, playComponents.targetNode.targetLetter == nil {
                playComponents.targetNode.setTarget(target: playComponents.activeEnemyLetter[0])
            }
            
            if playComponents.targetNode.hasTarget {
                playComponents.targetNode.followTarget()
            }
            
            break
        case GameStatus.GameOver:
            print("GameOver")
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case GameStatus.StandBy:

            standByComponents.removeComponents(gameScene: self)
            gameStatus = GameStatus.Play
//            playComponents.showAllComponents(scene: self)
//            initializePlayComponents()
            break
        case GameStatus.Play:

            break
        case GameStatus.GameOver:
            break
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playButtonExplode()
        playComponents.setUpKeyboard(scene: self)
    }
    
    
}

