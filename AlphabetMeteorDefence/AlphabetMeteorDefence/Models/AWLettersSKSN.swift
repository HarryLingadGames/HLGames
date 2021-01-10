//
//  AWLettersSKSN.swift
//  SpacegameReloaded
//
//  Created by Harry on 11/30/20.
//  Copyright © 2020 Training. All rights reserved.
//

import SpriteKit

class AWLettersSKSN: SKSpriteNode{
    
    var pixelValue: CGFloat!
    var finalPixelValue: CGFloat!
    var buttonHeight: CGFloat!
    var normalButtonWidth: CGFloat!
    var letter : Letter!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(skNode: SKSpriteNode, letter: Letter){
        super.init(texture: SKTexture(imageNamed: letter.name), color: UIColor.white, size: CGSize())
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        pixelValue = CGFloat(skNode.size.width / GameDimension.NUMBER_OF_PIXEL)
        finalPixelValue = pixelValue * 2
        buttonHeight = pixelValue * 37
        normalButtonWidth = pixelValue * 27
        self.letter = letter
        
        self.size = getButtonSize(skNode: skNode, letter: self.letter)
        self.position = getButtonPosition(skNode: skNode, letter: self.letter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getButtonSize(skNode: SKNode, letter: Letter) -> CGSize{
       if letter.level == GameDimension.LEVEL_2 && (letter.index == 0 || letter.index == 8){
            return getSquareGameButtonSize(skNode: skNode)
        }else if letter.level == GameDimension.LEVEL_1{
            return getLevel1GameButtonSize(skNode: skNode, index: letter.index)
        }else{
            return getGameButtonSize(skNode: skNode)
        }
        
    }
    
    private func getButtonPosition(skNode: SKNode, letter: Letter) -> CGPoint{
        switch letter.level {
        case GameDimension.LEVEL_4:
            return getLevel4ButtonPosition(skNode: skNode, index: letter.index)
        case GameDimension.LEVEL_3:
            return getLevel3ButtonPosition(skNode: skNode, index: letter.index)
        case GameDimension.LEVEL_2:
            return getLevel2ButtonPosition(skNode: skNode, index: letter.index)
        case GameDimension.LEVEL_1:
            return getLevel1ButtonPosition(skNode: skNode, index: letter.index)
        default:
            return getLevel4ButtonPosition(skNode: skNode, index: letter.index)
        }
    }
    
    private func getLevel4ButtonPosition(skNode: SKNode, index: Int) -> CGPoint{
        
        let totalSpaceWidth = pixelValue * CGFloat(index + 1)
        let finalSpaceWidth = (2 * totalSpaceWidth)
        let totalButtonWidth = self.size.width * CGFloat(index)
        
        let xPosition = finalSpaceWidth + totalButtonWidth
        let yPosition = (buttonHeight * 3) + (finalPixelValue * CGFloat(GameDimension.LEVEL_4))
    
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    private func getLevel3ButtonPosition(skNode: SKNode, index: Int) -> CGPoint{
        
        let firstPosition = pixelValue * 16.5
        
        let totalSpaceWidth = firstPosition + (finalPixelValue * CGFloat(index))
        let totalButtonWidth = normalButtonWidth * CGFloat(index)
        
        let xPosition = totalSpaceWidth + totalButtonWidth
        let yPosition = (buttonHeight * 2) + (finalPixelValue * CGFloat(GameDimension.LEVEL_3))
        
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    private func getLevel2ButtonPosition(skNode: SKNode, index: Int) -> CGPoint{
        
        let bigSpaceWidth = pixelValue * 6.5
        
        let squareButtonWidth = pixelValue * 37
        
        var totalSpaceWidth: CGFloat
        var totalButtonWidth: CGFloat
        
        if index == 0{
            totalSpaceWidth = finalPixelValue * CGFloat(index + 1)
            totalButtonWidth = 0
            
        }else{
            totalSpaceWidth = bigSpaceWidth + (finalPixelValue * CGFloat(index))
            totalButtonWidth = squareButtonWidth + (normalButtonWidth * CGFloat(index - 1))
        }
        
        var xPosition:CGFloat
        let yPosition: CGFloat = buttonHeight + (finalPixelValue * CGFloat(GameDimension.LEVEL_2))
        
        if index == 8{
            xPosition = pixelValue * 253
            
        }else{
            xPosition = totalSpaceWidth + totalButtonWidth
        }
        
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    private func getLevel1ButtonPosition(skNode: SKNode, index: Int) -> CGPoint{
        
        let abcLetterWidth = pixelValue * 59
        let spaceLetterWidth = pixelValue * 139
        
        let xPosition: CGFloat
        let yPosition: CGFloat = finalPixelValue * CGFloat(GameDimension.LEVEL_1)
        
        
        switch index {
        case 0:
            xPosition = finalPixelValue
            break
        case 1:
            xPosition = (finalPixelValue * 2) + abcLetterWidth
            break
        case 2:
            xPosition = (finalPixelValue * 3) + abcLetterWidth + spaceLetterWidth
            break
        default:
            xPosition = 0
            break
        }
        
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    
    private func getGameButtonSize(skNode: SKNode) -> CGSize{
        return CGSize(width: (pixelValue * 27), height: buttonHeight)
    }
    
    private func getSquareGameButtonSize(skNode: SKNode) -> CGSize{
        return CGSize(width: buttonHeight, height: buttonHeight)
    }
    
    private func getLevel1GameButtonSize(skNode: SKNode, index: Int) -> CGSize{
        
        var width: CGFloat
        switch index {
        case 0:
            width = pixelValue * 59
            break
        case 1:
            width = pixelValue * 139
            break
        case 2:
            width = pixelValue * 86
            break
        default:
            width = 0
        }
        
        return CGSize(width: width, height: buttonHeight)
        
        
    }
    
}
