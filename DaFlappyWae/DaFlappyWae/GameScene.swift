//
//  GameScene.swift
//  DaFlappyWae
//
//  Created by Matthew Izzo on 1/19/18.
//  Copyright © 2018 Matthew Izzo. All rights reserved.
//
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var isGameStarted = Bool(false)
    var isDied = Bool(false)
    let startSound = SKAction.playSoundFileNamed("doYouKnow.wav", waitForCompletion: false)
    let coinSound = SKAction.playSoundFileNamed("myBwooda.wav", waitForCompletion: false)
    let deathSound = SKAction.playSoundFileNamed("doNotKnow.wav", waitForCompletion: false)
    
    var score = Int(0)
    let coins = UserDefaults.standard.integer(forKey: "coinTotal")
    var coinAmount = Int(0)
    var scoreLbl = SKLabelNode()
    var highscoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var coinTotalLbl = SKLabelNode()
    var restartBtn = SKSpriteNode()
    var pauseBtn = SKSpriteNode()
    var logoImg = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var useDefault = true
    let ownBlueKnuckles = UserDefaults.standard.bool(forKey: "ownBlueKnuckles")
    let ownOrangeKnuckles = UserDefaults.standard.bool(forKey: "ownOrangeKnuckles")
    let ownYellowKnuckles = UserDefaults.standard.bool(forKey: "ownYellowKnuckles")
    let ownGreenKnuckles = UserDefaults.standard.bool(forKey: "ownGreenKnuckles")
    let ownPurpleKnuckles = UserDefaults.standard.bool(forKey: "ownPurpleKnuckles")
    
    //CREATE THE knuckles ATLAS FOR ANIMATION
    let knucklesAtlas = SKTextureAtlas(named:"player")
    var knucklesSprites = Array<Any>()
    var knuckles = SKSpriteNode()
    var repeatActionknuckles = SKAction()
    
    override func didMove(to view: SKView) {
        coinAmount = coins
        createScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameStarted == false {
            //1
            isGameStarted =  true
            knuckles.physicsBody?.affectedByGravity = true
            createPauseBtn()
            //2
            logoImg.run(SKAction.scale(to: 0.5, duration: 0.3), completion: {
                self.logoImg.removeFromParent()
            })
            taptoplayLbl.removeFromParent()
            //3
            self.knuckles.run(repeatActionknuckles)
            
            //1
            let spawn = SKAction.run({
                () in
                self.wallPair = self.createWalls()
                self.addChild(self.wallPair)
            })
            //2
            let delay = SKAction.wait(forDuration: 1.5)
            let SpawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
            self.run(spawnDelayForever)
            //3
            let distance = CGFloat(self.frame.width + wallPair.frame.width)
            let movePillars = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
            let removePillars = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([movePillars, removePillars])
            
            knuckles.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            knuckles.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
        } else {
            //4
            if isDied == false {
                knuckles.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                knuckles.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
        for touch in touches{
            let location = touch.location(in: self)
            //1
            if isDied == true{
                /*if buyBlueBtn.contains(location) && coinAmount >= 10 && ownBlueKnuckles == false{
                    coinAmount = coinAmount - 10
                    UserDefaults.standard.set(true, forKey: "ownBlueKnuckles")
                    storeMenuOpen = false
                    restartScene()
                }
                if buyOrangeBtn.contains(location) && coinAmount >= 10 && ownOrangeKnuckles == false{
                    coinAmount = coinAmount - 10
                    UserDefaults.standard.set(true, forKey: "ownOrangeKnuckles")
                    storeMenuOpen = false
                    restartScene()
                }
                if buyYellowBtn.contains(location) && coinAmount >= 10 && ownYellowKnuckles == false{
                    coinAmount = coinAmount - 10
                    UserDefaults.standard.set(true, forKey: "ownYellowKnuckles")
                    storeMenuOpen = false
                    restartScene()
                }
                if buyGreenBtn.contains(location) && coinAmount >= 10 && ownGreenKnuckles == false{
                    coinAmount = coinAmount - 10
                    UserDefaults.standard.set(true, forKey: "ownGreenKnuckles")
                    storeMenuOpen = false
                    restartScene()
                }
                if buyPurpleBtn.contains(location) && coinAmount >= 10 && ownPurpleKnuckles == false{
                    coinAmount = coinAmount - 10
                    UserDefaults.standard.set(true, forKey: "ownPurpleKnuckles")
                    storeMenuOpen = false
                    restartScene()
                }
                
                if useRedKnucklesBtn.contains(location){
                    knucklesSprites.append(knucklesAtlas.textureNamed("knuckles1"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("knuckles2"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("knuckles3"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("knuckles4"))
                    characterMenuOpen = false
                    restartScene()
                }
                if useBlueKnucklesBtn.contains(location) && ownBlueKnuckles == true {
                    knucklesSprites.append(knucklesAtlas.textureNamed("blueknuckles1"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("blueknuckles2"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("blueknuckles3"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("blueknuckles4"))
                    characterMenuOpen = false
                    restartScene()
                }
                if useOrangeKnucklesBtn.contains(location) && ownOrangeKnuckles == true {
                    knucklesSprites.append(knucklesAtlas.textureNamed("orangeknuckles1"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("orangeknuckles2"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("orangeknuckles3"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("orangeknuckles4"))
                    characterMenuOpen = false
                    restartScene()
                }
                if useYellowKnucklesBtn.contains(location) && ownYellowKnuckles == true {
                    knucklesSprites.append(knucklesAtlas.textureNamed("yellowknuckles1"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("yellowknuckles2"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("yellowknuckles3"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("yellowknuckles4"))
                    characterMenuOpen = false
                    restartScene()
                }
                if useGreenKnucklesBtn.contains(location) && ownGreenKnuckles == true {
                    knucklesSprites.append(knucklesAtlas.textureNamed("greenknuckles1"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("greenknuckles2"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("greenknuckles3"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("greenknuckles4"))
                    characterMenuOpen = false
                    restartScene()
                }
                if usePurpleKnucklesBtn.contains(location) && ownPurpleKnuckles == true {
                    knucklesSprites.append(knucklesAtlas.textureNamed("purpleknuckles1"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("purpleknuckles2"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("purpleknuckles3"))
                    knucklesSprites.append(knucklesAtlas.textureNamed("purpleknuckles4"))
                    characterMenuOpen = false
                    restartScene()
                }*/
                
                UserDefaults.standard.set(coinAmount, forKey: "coinTotal")
                
                if restartBtn.contains(location){
                    restartScene()
                }
            } else {
                //2
                if pauseBtn.contains(location){
                    if self.isPaused == false{
                        self.isPaused = true
                        pauseBtn.texture = SKTexture(imageNamed: "play")
                    } else {
                        self.isPaused = false
                        pauseBtn.texture = SKTexture(imageNamed: "pause")
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if isGameStarted == true{
            if isDied == false{
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                    }
                }))
            }
        }
    }
    
    func createScene(){
        run(startSound)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.knucklesCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.knucklesCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        for i in 0..<2 {
            let background = SKSpriteNode(imageNamed: "bg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        if useDefault == true{
            knucklesSprites.append(knucklesAtlas.textureNamed("knuckles1"))
            knucklesSprites.append(knucklesAtlas.textureNamed("knuckles2"))
            knucklesSprites.append(knucklesAtlas.textureNamed("knuckles3"))
            knucklesSprites.append(knucklesAtlas.textureNamed("knuckles4"))
        }
        
        self.knuckles = createknuckles()
        self.addChild(knuckles)
        
        //PREPARE TO ANIMATE THE knuckles AND REPEAT THE ANIMATION FOREVER
        let animateknuckles = SKAction.animate(with: self.knucklesSprites as! [SKTexture], timePerFrame: 0.1)
        self.repeatActionknuckles = SKAction.repeatForever(animateknuckles)
        
        scoreLbl = createScoreLabel()
        self.addChild(scoreLbl)
        
        highscoreLbl = createHighscoreLabel()
        self.addChild(highscoreLbl)
        
        coinTotalLbl = createCoinTotalLabel()
        self.addChild(coinTotalLbl)
        
        createLogo()
        
        taptoplayLbl = createTaptoplayLabel()
        self.addChild(taptoplayLbl)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.knucklesCategory && secondBody.categoryBitMask == CollisionBitMask.pillarCategory || firstBody.categoryBitMask == CollisionBitMask.pillarCategory && secondBody.categoryBitMask == CollisionBitMask.knucklesCategory || firstBody.categoryBitMask == CollisionBitMask.knucklesCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.knucklesCategory{
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            if isDied == false{
                run(deathSound)
                isDied = true
                createRestartBtn()
                if UserDefaults.standard.object(forKey: "highestScore") != nil {
                    let hscore = UserDefaults.standard.integer(forKey: "highestScore")
                    if hscore < Int(scoreLbl.text!)!{
                        UserDefaults.standard.set(scoreLbl.text, forKey: "highestScore")
                    }
                } else {
                    UserDefaults.standard.set(0, forKey: "highestScore")
                }
                pauseBtn.removeFromParent()
                self.knuckles.removeAllActions()
            }
        } else if firstBody.categoryBitMask == CollisionBitMask.knucklesCategory && secondBody.categoryBitMask == CollisionBitMask.coinCategory {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            coinAmount += 1
            coinTotalLbl.text = "Coins: \(coinAmount)"
            secondBody.node?.removeFromParent()
        } else if firstBody.categoryBitMask == CollisionBitMask.coinCategory && secondBody.categoryBitMask == CollisionBitMask.knucklesCategory {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            coinAmount += 1
            coinTotalLbl.text = "Coins: \(coinAmount)"
            firstBody.node?.removeFromParent()
        }
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        isDied = false
        isGameStarted = false
        score = 0
        createScene()
    }
}
