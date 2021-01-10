//
//  Dimension.swift
//  SpacegameReloaded
//
//  Created by Harry on 11/29/20.
//  Copyright © 2020 Training. All rights reserved.
//

import SpriteKit

class GameDimension{
    
    static let TARGET_GAMESCREEN_WIDTH :CGFloat = 414
    static let TARGET_GAMESCREEN_HEIGHT :CGFloat = 736
    
    static let ACTUAL_HEIGHT:CGFloat = 37
    static let ACTUAL_WIDTH:CGFloat = 27
    
    static let NUMBER_OF_PIXEL:CGFloat = 292

    static let LEVEL_4:Int = 4
    static let LEVEL_3:Int = 3
    static let LEVEL_2:Int = 2
    static let LEVEL_1:Int = 1
    
    static let SPACE_RATIO:CGFloat = 0.1
    static let BUTTON_RATIO:CGFloat = 0.9
    
    static let NUMBER_OF_SPACE_LEVEL_4:Int = 11
//    static let NUMBER_OF_BUTTONS_LEVEL_4:Int = 11
    
    static let TIME_ENEMY_WILL_APPEAR: TimeInterval = 0.75
    static let ENEMYLETTER_SPEED_OF_FALLING: TimeInterval = 6
    
    static let ANCHOR_POINTS: CGPoint = CGPoint(x: 0, y: 0)
}
