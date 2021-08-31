//
//  GameScene.swift
//  Assignment4
//
//  Created by Andrew Bell on 4/14/20.
//  Copyright © 2020 Andrew Bell. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starcounter : SKLabelNode?
    var rockcounter : SKLabelNode?
    var heartcounter : SKLabelNode?
    var energycounter : SKLabelNode?
    var gamestatuslabel : SKLabelNode?
    

    var floor: SKNode!
    var ceiling: SKNode!
    var rwall: SKNode!
    var lwall: SKNode!
    
    var background = SKSpriteNode(imageNamed: "bg")
    let grid = Grid(blockSize: 64.0, rows:12, cols:16)
    let gamestatuspanel = SKSpriteNode(imageNamed: "game-status-panel")
    let block = SKSpriteNode(imageNamed: "block")
    let caveman = SKSpriteNode(imageNamed: "cavemanR")
    let dino1 = SKSpriteNode(imageNamed: "dino1")
    let dino2 = SKSpriteNode(imageNamed: "dino2")
    let dino3 = SKSpriteNode(imageNamed: "dino3")
    let dino4 = SKSpriteNode(imageNamed: "dino4")
    let star = SKSpriteNode(imageNamed: "star")
    let food = SKSpriteNode(imageNamed: "food")
    let fire = SKSpriteNode(imageNamed: "fire")
    let starpiece = SKSpriteNode(imageNamed: "star")
    
    var timer = Timer()
    var timeduration = 0
    
    var heartcount = 3
    var energycount = 100
    
    var movementcount = 0
    var movement2count = 0
    
    var dino1timecount = 0
    var dino2timecount = 0
    
    var randomtime = 0
    var randomtime2 = 0
    
    var message = ("HELLO, WELCOME TO MAZEMAN!")
    
    var tapGR: UITapGestureRecognizer!
    
    override func didMove(to view: SKView) {
        
        //add physics
        self.physicsWorld.contactDelegate = self
        
        //add background to game
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background)
        backgroundColor = SKColor.white
        
        //add properties of nodes
        block.physicsBody = SKPhysicsBody(rectangleOf: block.size)
        block.physicsBody?.isDynamic = false
        
        //add grid
        
        grid!.position = CGPoint (x:frame.midX, y:frame.midY)
        grid!.isUserInteractionEnabled = true
        addChild(grid!)
        
        //add top blocks
        addblocktogrid(r: 0, c: 0)
        addblocktogrid(r: 0, c: 1)
        addblocktogrid(r: 0, c: 2)
        addblocktogrid(r: 0, c: 3)
        addblocktogrid(r: 0, c: 4)
        addblocktogrid(r: 0, c: 5)
        addblocktogrid(r: 0, c: 6)
        addblocktogrid(r: 0, c: 7)
        addblocktogrid(r: 0, c: 8)
        addblocktogrid(r: 0, c: 9)
        addblocktogrid(r: 0, c: 10)
        addblocktogrid(r: 0, c: 11)
        addblocktogrid(r: 0, c: 12)
        addblocktogrid(r: 0, c: 13)
        addblocktogrid(r: 0, c: 14)
        addblocktogrid(r: 0, c: 15)
        addblocktogrid(r: 1, c: 0)
        addblocktogrid(r: 1, c: 1)
        addblocktogrid(r: 1, c: 2)
        addblocktogrid(r: 1, c: 3)
        addblocktogrid(r: 1, c: 4)
        addblocktogrid(r: 1, c: 5)
        addblocktogrid(r: 1, c: 6)
        addblocktogrid(r: 1, c: 7)
        addblocktogrid(r: 1, c: 8)
        addblocktogrid(r: 1, c: 9)
        addblocktogrid(r: 1, c: 10)
        addblocktogrid(r: 1, c: 11)
        addblocktogrid(r: 1, c: 12)
        addblocktogrid(r: 1, c: 13)
        addblocktogrid(r: 1, c: 14)
        addblocktogrid(r: 1, c: 15)
        
        
        
        //add bottom blocks
        addblocktogrid(r: 11, c: 0)
        addblocktogrid(r: 11, c: 1)
        addblocktogrid(r: 11, c: 2)
        addblocktogrid(r: 11, c: 3)
        addblocktogrid(r: 11, c: 4)
        addwatertogrid(r: 11, c: 5)
        addblocktogrid(r: 11, c: 6)
        addblocktogrid(r: 11, c: 7)
        addblocktogrid(r: 11, c: 8)
        addblocktogrid(r: 11, c: 9)
        addblocktogrid(r: 11, c: 10)
        addwatertogrid(r: 11, c: 11)
        addblocktogrid(r: 11, c: 12)
        addblocktogrid(r: 11, c: 13)
        addblocktogrid(r: 11, c: 14)
        addblocktogrid(r: 11, c: 15)
        
        //add caveman to starting position
        //addcavemanRtogrid(r: 10, c: 0)
        
        //add star counter to bottom left
        addstartogrid(r: 11, c: 0)
        
        //add rock counter to bottom left
        addrocktogrid(r: 11, c: 1)
        
        //add heart counter to bottom left
        addhearttogrid(r: 11, c: 2)
        
        //add energy counter to bottom left
        addbatterytogrid(r: 11, c: 3)
        
        //add game status panel
        gamestatuspanel.position = CGPoint (x: 525, y: 700)
        addChild(gamestatuspanel)
        
        //initialize counters
        starcounter = SKLabelNode(text: "0")
        starcounter!.position = CGPoint (x: 30, y: 20)
        starcounter!.fontSize = 30
        starcounter!.fontColor = SKColor.white
        starcounter!.fontName = "Chalkduster"
        addChild(starcounter!)
        
        rockcounter = SKLabelNode(text: "10")
        rockcounter!.position = CGPoint (x: 100, y: 20)
        rockcounter!.fontSize = 30
        rockcounter!.fontColor = SKColor.white
        rockcounter!.fontName = "Chalkduster"
        addChild(rockcounter!)
        
        heartcounter = SKLabelNode(text: "\(heartcount)")
        heartcounter!.position = CGPoint (x: 160, y: 20)
        heartcounter!.fontSize = 30
        heartcounter!.fontColor = SKColor.white
        heartcounter!.fontName = "Chalkduster"
        addChild(heartcounter!)
        
        energycounter = SKLabelNode(text: "\(energycount)")
        energycounter!.position = CGPoint (x: 225, y: 20)
        energycounter!.fontSize = 30
        energycounter!.fontColor = SKColor.white
        energycounter!.fontName = "Chalkduster"
        addChild(energycounter!)
        
        gamestatuslabel = SKLabelNode(text: "\(message)")
        gamestatuslabel!.position = CGPoint (x: 515, y: 690)
        gamestatuslabel!.fontSize = 35
        gamestatuslabel!.fontColor = SKColor.white
        gamestatuslabel!.fontName = "ArialMT"
        addChild(gamestatuslabel!)
        
        //create timer and countdown
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.timeaction), userInfo: nil, repeats: true)
        
        //add swipe recognizers
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)

        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)

        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        //add walls
        
        addRightWall()
        
        addLeftWall()
        
        addfloorWall()
        
        addceilingWall()
        
        //add dinos to game randomly
        
        //dino1
        
        let dino1number = Int.random(in: 0 ... 1)
        
        if (dino1number == 0) {adddino1togrid(r: 11, c: 5)}
        
        else {adddino1togrid(r: 11, c: 11)}
        
        //dino2
        
        let dino2number = Int.random(in: 0 ... 8)
        
        if (dino2number == 0) {adddino2togrid(r: 2, c: 15)}
        
        else if (dino2number == 1) {adddino2togrid(r: 3, c: 15)}
            
        else if (dino2number == 2) {adddino2togrid(r: 4, c: 15)}
            
        else if (dino2number == 3) {adddino2togrid(r: 5, c: 15)}
            
        else if (dino2number == 4) {adddino2togrid(r: 6, c: 15)}
        
        else if (dino2number == 5) {adddino2togrid(r: 7, c: 15)}
            
        else if (dino2number == 6) {adddino2togrid(r: 8, c: 15)}
            
        else if (dino2number == 7) {adddino2togrid(r: 9, c: 15)}
        
        else {adddino2togrid(r: 10, c: 15)}
        
        //dino3
        
        adddino3togrid(r: 2, c: 0)
        
        //dino4
        
        dino4.position = CGPoint (x: 60, y: 674)
        dino4.physicsBody = SKPhysicsBody(rectangleOf: dino4.size)
        dino4.physicsBody?.affectedByGravity = false
        dino4.physicsBody?.density = 20
        dino4.physicsBody?.isDynamic = false
        addChild(dino4)
        
        //add random time
        
        randomtime = Int.random(in: 2 ... 4)
        randomtime2 = Int.random(in: 2 ... 4)
        
        //add bit masks
        
        addBitMasks()
        
        addcavemanRtogrid(r: 10, c: 0)
        
        addstarpiecetogrid(r: 3, c: 14)
        
        addfoodtogrid(r: 10, c: 12)
        
    }
    
    
    
    //this is for the time action

    @objc func timeaction() {
        timeduration += 1
        movementcount += 1
        movement2count += 1
        
        energycount -= 1
        energycounter?.text = "\(energycount)"
        
        
        if (timeduration < 16) {addrandomblock()}
        
        else {gamestatuslabel?.text = "I CAN'T GET THE COLLISION DETECTOR TO WORK =("}
        
        if (movementcount >= randomtime) {
        dino1move()
        movementcount = 0
        randomtime = Int.random(in: 2 ... 4)
        }
        
        if (movement2count >= randomtime2) {
        dino2move()
        movement2count = 0
        randomtime2 = Int.random(in: 2 ... 4)
        }
        
        if (energycount <= 0) {
            if (heartcount > 0){
            energycount = 100
            energycounter?.text = "\(energycount)"
            }
            heartcount -= 1
            heartcounter?.text = "\(heartcount)"
        }
        
        if (heartcount <= 0 && energycount <= 0) {
            energycount = 0
            energycounter?.text = "\(energycount)"
            heartcount = 0
            heartcounter?.text = "\(heartcount)"
            timer.invalidate()
            
            gameover()
        }
 
    }
    
    //gesture functions
    
    @objc func swipedRight(sender:UISwipeGestureRecognizer){
        caveman.removeAllActions()
        let right = SKAction.moveBy(x: 1024, y: 0, duration: 2)
        caveman.run(right)
    }
    @objc func swipedLeft(sender:UISwipeGestureRecognizer){
        caveman.removeAllActions()
        let left = SKAction.moveBy(x: -1024, y: 0, duration: 2)
        caveman.run(left)
    }
    @objc func swipedUp(sender:UISwipeGestureRecognizer){
        caveman.removeAllActions()
        let up = SKAction.moveBy(x: 0, y: 768, duration: 2)
        caveman.run(up)
    }
    @objc func swipedDown(sender:UISwipeGestureRecognizer){
        caveman.removeAllActions()
        let down = SKAction.moveBy(x: 0, y: -768, duration: 2)
        caveman.run(down)
    }
    
    //grid functions
    
    func addblocktogrid(r: Int, c: Int) {
        let gamePiece = block.copy() as! SKSpriteNode
        gamePiece.position = grid!.gridPosition(row: r, col: c)
       // gamePiece.physicsBody = SKPhysicsBody(rectangleOf: gamePiece.size)
       // gamePiece.physicsBody?.isDynamic = false
        grid!.addChild(gamePiece)
    }
    
    func addwatertogrid(r: Int, c: Int) {
        let waterPiece = SKSpriteNode(imageNamed: "water")
        waterPiece.position = grid!.gridPosition(row: r, col: c)
        grid!.addChild(waterPiece)
    }
    
    func addcavemanRtogrid(r: Int, c: Int) {
        caveman.position = grid!.gridPosition(row: r, col: c)
        caveman.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 65, height: 65))
        caveman.physicsBody?.affectedByGravity = false
        caveman.physicsBody?.density = 1
        caveman.physicsBody?.isDynamic = true
        grid!.addChild(caveman)
    }
    
    func adddino1togrid(r: Int, c: Int) {
        dino1.position = grid!.gridPosition(row: r, col: c)
        dino1.physicsBody = SKPhysicsBody(rectangleOf: dino1.size)
        dino1.physicsBody?.affectedByGravity = false
        dino1.physicsBody?.density = 30
        dino1.physicsBody?.isDynamic = true
        grid!.addChild(dino1)
    }
    
    func adddino2togrid(r: Int, c: Int) {
        dino2.position = grid!.gridPosition(row: r, col: c)
        dino2.physicsBody = SKPhysicsBody(rectangleOf: dino2.size)
        dino2.physicsBody?.affectedByGravity = false
        dino2.physicsBody?.density = 30
        dino2.physicsBody?.isDynamic = true
        grid!.addChild(dino2)
    }
    
    func adddino3togrid(r: Int, c: Int) {
        dino3.position = grid!.gridPosition(row: r, col: c)
        dino3.physicsBody = SKPhysicsBody(rectangleOf: dino3.size)
        dino3.physicsBody?.affectedByGravity = false
        dino3.physicsBody?.density = 30
        dino3.physicsBody?.isDynamic = true
        grid!.addChild(dino3)
    }
    
    func addstarpiecetogrid(r: Int, c: Int) {
        starpiece.position = grid!.gridPosition(row: r, col: c)
        starpiece.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 65, height: 65))
        starpiece.physicsBody?.affectedByGravity = false
        starpiece.physicsBody?.density = 30
        starpiece.physicsBody?.isDynamic = true
        grid!.addChild(starpiece)
    }
    
    func addfoodtogrid(r: Int, c: Int) {
        food.position = grid!.gridPosition(row: r, col: c)
        food.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 65, height: 65))
        food.physicsBody?.affectedByGravity = false
        food.physicsBody?.density = 30
        food.physicsBody?.isDynamic = true
        grid!.addChild(food)
    }
    
    
    func addstartogrid(r: Int, c: Int) {
        star.position = grid!.gridPosition(row: r, col: c)
        grid!.addChild(star)
    }
    
    func addrocktogrid(r: Int, c: Int) {
        let gamePiece = SKSpriteNode(imageNamed: "rock")
        gamePiece.position = grid!.gridPosition(row: r, col: c)
        grid!.addChild(gamePiece)
    }
    
    func addhearttogrid(r: Int, c: Int) {
        let gamePiece = SKSpriteNode(imageNamed: "heart")
        gamePiece.position = grid!.gridPosition(row: r, col: c)
        grid!.addChild(gamePiece)
    }
    
    func addbatterytogrid(r: Int, c: Int) {
        let gamePiece = SKSpriteNode(imageNamed: "battery")
        gamePiece.position = grid!.gridPosition(row: r, col: c)
        grid!.addChild(gamePiece)
    }
        
    
    //dino movement functions
    
    func dino1move(){
        let moveup = SKAction.moveBy(x: 0, y: 576, duration: 1)
        let movedown = SKAction.moveBy(x: 0, y: -576, duration: 1)
        
        let dino1movenumber = Int.random(in: 0 ... 1)
        
        if (dino1movenumber == 0) {dino1.run(moveup)}
        
        else {dino1.run(movedown)}
    }
    
    func dino2move(){
        
        let dino2movenumber = Int.random(in: 0 ... 1)
        
        if (dino2movenumber == 0) {dino2.run(SKAction.moveBy(x: 768, y: 0, duration: 1), withKey: "d2moveleft")}
        
        else {dino2.run(SKAction.moveBy(x: -768, y: 0, duration: 1), withKey: "d2moveright")}
    }
    
    
    
    func addrandomblock(){
      let randomr = Int.random(in: 2 ... 10)
      let randomc = Int.random(in: 0 ... 15)
        
      let rblock = block.copy() as! SKSpriteNode
      rblock.position = grid!.gridPosition(row: randomr, col: randomc)
      grid!.addChild(rblock)
        
        
    }
    
    
    //add right wall
    
    func addRightWall(){
        
        rwall = SKNode()
        
        rwall.position = CGPoint(x: 1024, y: self.frame.height/2)
        
        rwall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height:self.frame.height))
        
        addChild(rwall)
        
        rwall.physicsBody?.isDynamic = false
        
    }
    
    //add left wall
    
    func addLeftWall(){
        
        lwall = SKNode()
        
        lwall.position = CGPoint(x: -5, y: self.frame.height/2)
        
        lwall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height:self.frame.height))
        
        addChild(lwall)
        
        lwall.physicsBody?.isDynamic = false
        
    }
    
    //add floor wall
    
    func addfloorWall(){
        
        floor = SKNode()
        
        floor.position = CGPoint(x: self.frame.width/2, y: 0)
        
        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 10))
        
        addChild(floor)
        
        floor.physicsBody?.isDynamic = false
        
    }
    
    //add ceiling wall
    
    func addceilingWall(){
        
        ceiling = SKNode()
        
        ceiling.position = CGPoint(x: self.frame.width/2, y: 640)
        
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 10))
        
        addChild(ceiling)
        
        ceiling.physicsBody?.isDynamic = false
        
    }
    
    //add bit masks
    
    func addBitMasks(){
        
        block.physicsBody?.categoryBitMask = PhysicsCategory.block
        block.physicsBody?.contactTestBitMask = PhysicsCategory.dino3 | PhysicsCategory.dino4
        block.physicsBody?.collisionBitMask = PhysicsCategory.dino2 | PhysicsCategory.caveman | PhysicsCategory.dino3
        
        
        caveman.physicsBody?.categoryBitMask = PhysicsCategory.caveman
        caveman.physicsBody?.contactTestBitMask = PhysicsCategory.starpiece | PhysicsCategory.food
        caveman.physicsBody?.collisionBitMask = PhysicsCategory.starpiece | PhysicsCategory.food //| PhysicsCategory.Ball
        
        dino1.physicsBody?.categoryBitMask = PhysicsCategory.dino1
        dino1.physicsBody?.contactTestBitMask = PhysicsCategory.caveman | PhysicsCategory.block
        dino1.physicsBody?.collisionBitMask = PhysicsCategory.block | PhysicsCategory.caveman //| PhysicsCategory.Ball
        
        dino2.physicsBody?.categoryBitMask = PhysicsCategory.dino2
        dino2.physicsBody?.contactTestBitMask = PhysicsCategory.lwall | PhysicsCategory.rwall
        dino2.physicsBody?.collisionBitMask = PhysicsCategory.lwall | PhysicsCategory.rwall //| PhysicsCategory.Ball
        
        
        dino3.physicsBody?.categoryBitMask = PhysicsCategory.dino3
        dino3.physicsBody?.contactTestBitMask = PhysicsCategory.caveman | PhysicsCategory.block
        dino3.physicsBody?.collisionBitMask = PhysicsCategory.block | PhysicsCategory.caveman //| PhysicsCategory.Ball
        
        rwall.physicsBody?.categoryBitMask = PhysicsCategory.rwall
        rwall.physicsBody?.collisionBitMask = PhysicsCategory.dino2
        
        lwall.physicsBody?.categoryBitMask = PhysicsCategory.lwall
        lwall.physicsBody?.collisionBitMask = PhysicsCategory.dino2
        
        food.physicsBody?.categoryBitMask = PhysicsCategory.food
        food.physicsBody?.contactTestBitMask = PhysicsCategory.caveman
        food.physicsBody?.collisionBitMask = PhysicsCategory.caveman
        
        starpiece.physicsBody?.categoryBitMask = PhysicsCategory.starpiece
        starpiece.physicsBody?.contactTestBitMask = PhysicsCategory.caveman
        starpiece.physicsBody?.collisionBitMask = PhysicsCategory.caveman
        
    }
    
    //create physics rules
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.block && contact.bodyB.categoryBitMask == PhysicsCategory.block) || (contact.bodyB.categoryBitMask == PhysicsCategory.block && contact.bodyA.categoryBitMask == PhysicsCategory.block) {
            
            print("Ball contacts circle - BONUS obtained")
            
            self.removeFromParent()
            
            addrandomblock()
        
        }
        
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.dino2 && contact.bodyB.categoryBitMask == PhysicsCategory.rwall) || (contact.bodyB.categoryBitMask == PhysicsCategory.dino2 && contact.bodyA.categoryBitMask == PhysicsCategory.rwall){
            
            dino2.removeAction(forKey: "d2moveright")
            dino2.removeAction(forKey: "d2moveleft")
            print("Circle hits ground")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.dino2 && contact.bodyB.categoryBitMask == PhysicsCategory.lwall) || (contact.bodyB.categoryBitMask == PhysicsCategory.dino2 && contact.bodyA.categoryBitMask == PhysicsCategory.lwall){
           
            dino2.removeAction(forKey: "d2moveleft")
            dino2.removeAction(forKey: "d2moveright")
            print("Circle hits ground")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.caveman && contact.bodyB.categoryBitMask == PhysicsCategory.food) || (contact.bodyB.categoryBitMask == PhysicsCategory.caveman && contact.bodyA.categoryBitMask == PhysicsCategory.food){
           
           
            print("Ate Food")
        }
        
        if (contact.bodyA.categoryBitMask == PhysicsCategory.caveman && contact.bodyB.categoryBitMask == PhysicsCategory.starpiece) || (contact.bodyB.categoryBitMask == PhysicsCategory.caveman && contact.bodyA.categoryBitMask == PhysicsCategory.starpiece){
           
            
            print("Collected Starpiece")
        }
        
        
        
        
    }
    
    //create physics category
    
    struct PhysicsCategory {
        static let block: UInt32 = 0x1 << 0
        static let caveman: UInt32 = 0x1 << 1
        static let dino1: UInt32 = 0x1 << 2
        static let dino2: UInt32 = 0x1 << 3
        static let dino3: UInt32 = 0x1 << 4
        static let dino4: UInt32 = 0x1 << 5
        static let rwall: UInt32 = 0x1 << 6
        static let lwall: UInt32 = 0x1 << 7
        static let food: UInt32 = 0x1 << 8
        static let starpiece: UInt32 = 0x1 << 9
    }
    
    //create gameover transition
    
    func gameover(){
        // transition to game over scene
        
        let flipTransition = SKTransition.fade(withDuration: 0.3)
            
            //SKTransition.doorsCloseHorizontal(withDuration: 1.0)
        let gameOverScene = GameOverScene(size: self.size)
        gameOverScene.scaleMode = .aspectFill
        
        self.view?.presentScene(gameOverScene, transition: flipTransition)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


class Grid:SKSpriteNode {
    var rows:Int!
    var cols:Int!
    var blockSize:CGFloat!

    convenience init?(blockSize:CGFloat,rows:Int,cols:Int) {
        guard let texture = Grid.gridTexture(blockSize: blockSize,rows: rows, cols:cols) else {
            return nil
        }
        self.init(texture: texture, color:SKColor.clear, size: texture.size())
        self.blockSize = blockSize
        self.rows = rows
        self.cols = cols
    }

    class func gridTexture(blockSize:CGFloat,rows:Int,cols:Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols)*blockSize+1.0, height: CGFloat(rows)*blockSize+1.0)
        UIGraphicsBeginImageContext(size)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        SKColor.clear.setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return SKTexture(image: image!)
    }

    func gridPosition(row:Int, col:Int) -> CGPoint {
        let offset = blockSize / 2.0 + 0.5
        let x = CGFloat(col) * blockSize - (blockSize * CGFloat(cols)) / 2.0 + offset
        let y = CGFloat(rows - row - 1) * blockSize - (blockSize * CGFloat(rows)) / 2.0 + offset
        return CGPoint(x:x, y:y)
    }
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in:self)
            let node = atPoint(position)
            if node != self {
                let action = SKAction.rotate(byAngle: CGFloat.pi*2, duration: 1)
                node.run(action)
            }
            else {
                let x = size.width / 2 + position.x
                let y = size.height / 2 - position.y
                let row = Int(floor(x / blockSize))
                let col = Int(floor(y / blockSize))
                print("\(row) \(col)")
                
            
            }
        }
    }*/
}
