//
//  GameElements.swift
//  DaFlappyWae
//
//  Created by Matthew Izzo on 1/19/18.
//  Copyright © 2018 Matthew Izzo. All rights reserved.
//

import Foundation
import SpriteKit

struct CollisionBitMask {
    static let knucklesCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let coinCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    func createknuckles() -> SKSpriteNode {
        //1
        let knuckles = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("knuckles1"))
        knuckles.size = CGSize(width: 50, height: 50)
        knuckles.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        //2
        knuckles.physicsBody = SKPhysicsBody(circleOfRadius: knuckles.size.width / 2)
        knuckles.physicsBody?.linearDamping = 1.1
        knuckles.physicsBody?.restitution = 0
        //3
        knuckles.physicsBody?.categoryBitMask = CollisionBitMask.knucklesCategory
        knuckles.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        knuckles.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.coinCategory | CollisionBitMask.groundCategory
        //4
        knuckles.physicsBody?.affectedByGravity = false
        knuckles.physicsBody?.isDynamic = true
        
        return knuckles
    }
    
    //1
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    //2
    func createPauseBtn() {
        pauseBtn = SKSpriteNode(imageNamed: "pause")
        pauseBtn.size = CGSize(width:60, height:60)
        pauseBtn.position = CGPoint(x: self.frame.width - 30, y: 30)
        pauseBtn.zPosition = 6
        self.addChild(pauseBtn)
    }
    //3
    func createScoreLabel() -> SKLabelNode {
        let scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.6)
        scoreLbl.text = "\(score)"
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 50
        scoreLbl.fontName = "GurmukhiMN-Bold"
        
        let scoreBg = SKShapeNode()
        scoreBg.position = CGPoint(x: 0, y: 0)
        scoreBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100), height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil)
        let scoreBgColor = UIColor(red: CGFloat(255.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.4))
        scoreBg.fillColor = scoreBgColor
        scoreBg.zPosition = -1
        scoreLbl.addChild(scoreBg)
        return scoreLbl
    }
    //4
    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        highscoreLbl.position = CGPoint(x: self.frame.width/5, y: self.frame.height - 22)
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highscoreLbl.text = "High Score: \(highestScore)"
        } else {
            highscoreLbl.text = "High Score: 0"
        }
        highscoreLbl.zPosition = 5
        highscoreLbl.fontSize = 20
        highscoreLbl.fontName = "GurmukhiMN-Bold"
        return highscoreLbl
    }
    
    func createCoinTotalLabel() -> SKLabelNode {
        let coinTotalLbl = SKLabelNode()
        coinTotalLbl.position = CGPoint(x: self.frame.width/5, y:self.frame.height - 44)
        coinTotalLbl.text = "Coins: \(coinAmount)"
        coinTotalLbl.zPosition = 5
        coinTotalLbl.fontSize = 20
        coinTotalLbl.fontName = "GurmukhiMN-Bold"
        return coinTotalLbl
    }
    
    //5
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.size = CGSize(width: 272, height: 65)
        logoImg.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 100)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    //6
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        taptoplayLbl.text = "Tap to find da WAE"
        taptoplayLbl.fontColor = UIColor(red: 200/255, green: 0/255, blue: 0/255, alpha: 1.0)
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 30
        taptoplayLbl.fontName = "GurmukhiMN-Bold"
        return taptoplayLbl
    }
    
    
    func createWalls() -> SKNode  {
        // 1
        let coinNode = SKSpriteNode(imageNamed: "coin")
        coinNode.size = CGSize(width: 40, height: 40)
        coinNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        coinNode.physicsBody = SKPhysicsBody(rectangleOf: coinNode.size)
        coinNode.physicsBody?.affectedByGravity = false
        coinNode.physicsBody?.isDynamic = false
        coinNode.physicsBody?.categoryBitMask = CollisionBitMask.coinCategory
        coinNode.physicsBody?.collisionBitMask = 0
        coinNode.physicsBody?.contactTestBitMask = CollisionBitMask.knucklesCategory
        coinNode.color = SKColor.blue
        // 2
        wallPair = SKNode()
        wallPair.name = "wallPair"
        
        let topWall = SKSpriteNode(imageNamed: "pillar")
        let btmWall = SKSpriteNode(imageNamed: "pillar")
        
        topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 420)
        btmWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 420)
        
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        topWall.physicsBody?.collisionBitMask = CollisionBitMask.knucklesCategory
        topWall.physicsBody?.contactTestBitMask = CollisionBitMask.knucklesCategory
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        btmWall.physicsBody?.collisionBitMask = CollisionBitMask.knucklesCategory
        btmWall.physicsBody?.contactTestBitMask = CollisionBitMask.knucklesCategory
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false
        
        topWall.zRotation = CGFloat.pi
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        wallPair.zPosition = 1
        // 3
        let randomPosition = random(min: -200, max: 200)
        wallPair.position.y = wallPair.position.y +  randomPosition
        wallPair.addChild(coinNode)
        
        wallPair.run(moveAndRemove)
        
        return wallPair
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
}
