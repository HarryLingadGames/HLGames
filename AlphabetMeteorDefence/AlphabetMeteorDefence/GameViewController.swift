//
//  GameViewController.swift
//  AlphabetMeteorDefence
//
//  Created by Harry Lingad on 1/10/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameViewControllerProtocol {

    func fireTorpedo(type: LetterType)
}

protocol PlayComponentProtocol {
    func setKeyboardHeight(height: CGFloat)
}

class GameViewController: UIViewController, KeyBoardProtocol, UITextFieldDelegate {


    var awTextField: UITextField = UITextField()
    var gameDelegate: GameViewControllerProtocol?
    var playComponentDelegate: PlayComponentProtocol?
    var isKeyBoardShown: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DEVICE SCREEN WIDTH: \(self.view.frame.width)")
        print("DEVICE SCREEN HEIGHT: \(self.view.frame.height)")
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
//                sceneNode.playComponents.gameViewController = self
                sceneNode.gameViewController = self
                sceneNode.keyBoardDelegate = self
                sceneNode.size.width = self.view.frame.width
                sceneNode.size.height = (self.view.frame.width * GameDimension.TARGET_GAMESCREEN_HEIGHT) / GameDimension.TARGET_GAMESCREEN_WIDTH
                
                
                print("GAMESCREEN WIDTH: \(sceneNode.size.width)")
                print("GAMESCREEN HEIGHT: \(sceneNode.size.height)")
                
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
//
                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
//                sceneNode.scaleMode = .fill
                sceneNode.scaleMode = .resizeFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        awTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func showKeyboard() {
        awTextField.autocapitalizationType = .none
        awTextField.autocorrectionType = .no
        awTextField.keyboardType = .asciiCapable
        awTextField.sizeThatFits(CGSize(width: 0, height: 0))
        awTextField.becomeFirstResponder()
        self.view.addSubview(awTextField)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, !isKeyBoardShown {
            playComponentDelegate?.setKeyboardHeight(height: keyBoardSize.height)
            isKeyBoardShown = true
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("TYPED: \(String(describing: string))")
        awTextField.text = ""
        gameDelegate?.fireTorpedo(type: LetterType.getType(stringLetter: string))
        return true
    }


    

    

}
