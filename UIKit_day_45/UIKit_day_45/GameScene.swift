//
//  GameScene.swift
//  UIKit_day_45
//
//  Created by user on 2023/05/26.
//

import SpriteKit


class GameScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        makeBouncer(at: CGPoint(x: 0, y:0))
        makeBouncer(at: CGPoint(x: 256, y:0))
        makeBouncer(at: CGPoint(x: 512, y:0))
        makeBouncer(at: CGPoint(x: 768, y:0))
        makeBouncer(at: CGPoint(x: 1024, y:0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let ball = SKSpriteNode(imageNamed: "ballRed")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.restitution = 0.4 // bounciness
        ball.position = location
        addChild(ball)
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false // object still collide with other things but it will not be moved and fixed in position
        addChild(bouncer)
    }
}
