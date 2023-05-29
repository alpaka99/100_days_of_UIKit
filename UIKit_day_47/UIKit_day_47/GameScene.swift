//
//  GameScene.swift
//  UIKit_day_47
//
//  Created by user on 2023/05/30.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var ballLimitLabel: SKLabelNode!
    var ballLimit = 5 {
        didSet {
            ballLimitLabel.text = "ballLimit: \(ballLimit)"
        }
    }
    
    let ballColors = ["ballRed", "ballYellow", "ballGreen","ballCyan", "ballBlue", "ballPurple", "ballGrey"]
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsWorld.contactDelegate = self
        
        // add Bouncer
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        
        // add Slot
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        // set score Label
        scoreLabel = SKLabelNode(fontNamed: "ChalkDuster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        // set edit Label
        editLabel = SKLabelNode(fontNamed: "ChalkDuster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        // set ballLimit Label
        ballLimitLabel = SKLabelNode(fontNamed: "ChalkDuster")
        ballLimitLabel.text = "ballLimit: 5"
        ballLimitLabel.position = CGPoint(x: 512, y: 700)
        addChild(ballLimitLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let objects = nodes(at: location)
            
            if objects.contains(editLabel) {
                editingMode.toggle()
            } else {
                if editingMode {
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(
                        red: CGFloat.random(in: 0...1),
                        green: CGFloat.random(in: 0...1),
                        blue: CGFloat.random(in: 0...1),
                        alpha: 1), size: size)
                    
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOf: size)
                    box.name = "box"
                    box.physicsBody?.isDynamic = false
                    
                    addChild(box)
                    
                } else {
                    guard ballLimit > 0 else { return }
                    ballLimit -= 1
                    let ball = SKSpriteNode(imageNamed: ballColors[Int.random(in: 0...ballColors.count-1)])
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.physicsBody?.restitution = 0.4
                    ball.position = location
                    ball.position.y = frame.maxY
                    ball.name = "ball"
                    
                    addChild(ball)
                    
                }
            }
        }
    }
    
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotBase)
        
        slotGlow.position = position
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(object1: SKNode, object2: SKNode) {
        if object2.name == "good" {
            destroy(object: object1)
            score += 1
            ballLimit += 1
        } else if object2.name == "bad" {
            destroy(object: object1)
            score -= 1
        } else if object1.name == "box" {
            destroy(object: object1)
        } else if object2.name == "box" {
            destroy(object: object2)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(object1: nodeA, object2: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(object1: nodeB, object2: nodeA)
        } else if nodeA.name == "box" {
            collisionBetween(object1: nodeA, object2: nodeB)
        } else if nodeB.name == "box" {
            collisionBetween(object1: nodeB, object2: nodeA)
        }
                
    }
    
    func destroy(object: SKNode) {
        if object.name == "ball" {
            if let fireParticle = SKEmitterNode(fileNamed: "FireParticles") {
                fireParticle.position = object.position
                addChild(fireParticle)
            }
        }

        object.removeFromParent()
    }
}
