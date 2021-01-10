//
//  AWGamePlayComponents.swift
//  AlphabetWar
//
//  Created by Harry on 12/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class AWGamePlayComponents: NSObject, PlayComponentProtocol {

    var starfield:SKEmitterNode!
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var highScoreLabel:SKLabelNode!
    var highScore:Int = 0 {
        didSet {
            highScoreLabel.text = "HighScore: \(highScore)"
        }
    }

    var pauseLabel:SKLabelNode!
    
    var gameTimer:Timer!
    
    var letterButtons: ButtonsSKNode!
    var targetNode: TargetNode!
    
    var enemyLetterNames = [LetterType.a,
                            LetterType.b,
                            LetterType.c,
                            LetterType.d,
                            LetterType.e,
                            LetterType.f,
                            LetterType.g,
                            LetterType.h,
                            LetterType.i,
                            LetterType.j,
                            LetterType.k,
                            LetterType.l,
                            LetterType.m,
                            LetterType.n,
                            LetterType.o,
                            LetterType.p,
                            LetterType.q,
                            LetterType.r,
                            LetterType.s,
                            LetterType.t,
                            LetterType.v,
                            LetterType.x,
                            LetterType.y,
                            LetterType.z]
    
    var activeEnemyLetter = [EnemyLetterNode]()
    
    
    let alienCategory:UInt32 = 0x1 << 1
    let photonTorpedoCategory:UInt32 = 0x1 << 0
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0

    var scene: GameScene = GameScene()
    var gameViewController: GameViewController?
    
    override init() {
        super.init()
    }

    init(gameScene: GameScene){
        super.init()

        //MARK: - TEMP
        scene = gameScene
        gameViewController = scene.gameViewController
        gameViewController?.playComponentDelegate = self
        scene.gameViewController?.gameDelegate = scene

        setUpLetterButtons(scene: gameScene)
        setUpActiveEnemyLetter(scene: gameScene)
        setUpStarField(scene: gameScene)
        setUpScoreLabel(scene: gameScene)
        setUpHighScoreLabel(scene: gameScene)
        setUpPauseLabel(scene: gameScene)
        setUpTargetNode(scene: gameScene)
        setUpPhysicsWorld(scene: gameScene)
        setUpMotionManager(scene: gameScene)
        setUpGameTime(scene: gameScene)
        hideAllComponents(gameScene: gameScene)
    }


    
    func removeComponents(gameScene: GameScene){
        gameScene.removeAllChildren()
    }
    
    func hideAllComponents(gameScene: GameScene){
        
        if gameTimer != nil{
            gameTimer.invalidate()
        }
        
        for enemy in activeEnemyLetter{
            enemy.removeFromParent()
        }
        activeEnemyLetter.removeAll()
        
        targetNode.isHidden = true
        targetNode.removeTarget()
        
        scoreLabel.run(SKAction.move(to: CGPoint(x: 50, y: gameScene.frame.size.height + 60), duration: 0.3))
        highScoreLabel.run(SKAction.move(to: CGPoint(x: -100, y: gameScene.frame.size.height - 100), duration: 0.3))
        letterButtons.run(SKAction.move(to: CGPoint(x: 0, y: -letterButtons.size.height), duration: 0.3))
        
    }
    
    func showAllComponents(scene: GameScene){
        gameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(GameDimension.TIME_ENEMY_WILL_APPEAR), target: scene, selector: #selector(scene.addEnemyLetter), userInfo: nil, repeats: true)
        letterButtons.zPosition = 1
        
        targetNode.isHidden = false
        
        scoreLabel.run(SKAction.move(to: CGPoint(x: 50, y: scene.frame.size.height - 70), duration: 0.3))
        highScoreLabel.run(SKAction.move(to: CGPoint(x: 75, y: scene.frame.size.height - 100), duration: 0.3))
        pauseLabel.run(SKAction.move(to: CGPoint(x: scene.size.width - 40, y: scene.frame.size.height - 80), duration: 0.3))
        letterButtons.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.5))
    }

    private func setUpLetterButtons(scene: GameScene) {
        letterButtons = ButtonsSKNode(gameScene: scene, color: UIColor.systemBlue, size: CGSize(width: scene.size.width, height: scene.size.width))
        letterButtons.anchorPoint = GameDimension.ANCHOR_POINTS
        letterButtons.position = CGPoint(x: 0, y: -letterButtons.size.height)

        print("Buttons Width: \(letterButtons.size.width)")
        letterButtons.isHidden = true
        scene.addChild(letterButtons)
    }

    private func setUpActiveEnemyLetter(scene: GameScene) {
        activeEnemyLetter = [EnemyLetterNode]()
    }

    private func setUpStarField(scene: GameScene) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: scene.size.height)
        starfield.advanceSimulationTime(10)
        scene.addChild(starfield)
        starfield.zPosition = -1
    }

    private func setUpScoreLabel(scene: GameScene) {
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 50, y: scene.frame.size.height + 60)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 20

        scoreLabel.fontColor = UIColor.white
        score = 0
        scene.addChild(scoreLabel)
    }

    private func setUpHighScoreLabel(scene: GameScene) {
        highScoreLabel = SKLabelNode(text: "HighScore: 0")
        highScoreLabel.position = CGPoint(x: -100, y: scene.frame.size.height - 100)
        highScoreLabel.fontName = "AmericanTypewriter-Bold"
        highScoreLabel.fontSize = 20

        highScoreLabel.fontColor = UIColor.white
        highScore = 0
        scene.addChild(highScoreLabel)
    }

    private func setUpPauseLabel(scene: GameScene) {
        pauseLabel = SKLabelNode(text: "||")
        pauseLabel.position = CGPoint(x: scene.size.width - 40, y: scene.frame.size.height + 60)
        pauseLabel.fontName = "AmericanTypewriter-Bold"
        pauseLabel.fontSize = 25

        pauseLabel.fontColor = UIColor.white
        scene.addChild(pauseLabel)
    }

    private func setUpTargetNode(scene: GameScene) {
        targetNode = TargetNode(gameScene: scene, imageNamed: "target", hasTarget: false)
    }

    private func setUpPhysicsWorld(scene: GameScene) {
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        scene.physicsWorld.contactDelegate = scene
    }

    private func setUpMotionManager(scene: GameScene) {
        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                scene.xAcceleration = CGFloat(acceleration.x) * 0.75 + scene.xAcceleration * 0.25
            }
        }
    }

    private func setUpGameTime(scene: GameScene) {
        gameTimer = Timer()
    }

    func setUpKeyboard(scene: GameScene) {
        scene.keyBoardDelegate?.showKeyboard()
    }

    func setKeyboardHeight(height: CGFloat) {
        letterButtons.size = CGSize(width: scene.size.width, height: height)
    }
   
}
