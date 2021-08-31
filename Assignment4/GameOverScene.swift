//
//  GameOverScene.swift
//  Assignment4
//
//  Created by Andrew Bell on 4/15/20.
//  Copyright © 2020 Andrew Bell. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    override init(size: CGSize){
        
        super.init(size: size)
        
        backgroundColor = SKColor.white
        let currentscoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        currentscoreLabel.text = ("Current Score is 3")
        currentscoreLabel.fontSize = 60
        currentscoreLabel.fontColor = SKColor.blue
        
        let highscoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        highscoreLabel.text = ("High Scores 3, 0, 0")
        highscoreLabel.fontSize = 35
        highscoreLabel.fontColor = SKColor.black
        
        let newgameLabel = SKLabelNode(fontNamed: "Chalkduster")
        newgameLabel.text = ("Begin New Game")
        newgameLabel.fontSize = 35
        newgameLabel.fontColor = UIColor(red: 0.102, green: 0.6275, blue: 0, alpha: 1.0)
        
        currentscoreLabel.position = CGPoint(x: 512, y: 434)
        self.addChild(currentscoreLabel)
        highscoreLabel.position = CGPoint(x: 512, y: 334)
        self.addChild(highscoreLabel)
        newgameLabel.position = CGPoint(x: 512, y: 234)
        self.addChild(newgameLabel)
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch  = touches.first
        
        let loc = touch?.location(in: self.view)
        
        print(loc as Any)
       
            // transition to game scene
            
        let flipTransition = SKTransition.fade(withDuration: 0.3)
            let newScene = GameScene(size: self.size)
            newScene.scaleMode = .aspectFill
            
            self.view?.presentScene(newScene, transition: flipTransition)
        
       
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
