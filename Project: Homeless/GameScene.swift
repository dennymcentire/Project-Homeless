//
//  GameScene.swift
//  Project: Homeless
//
//  Created by Family on 2/16/17.
//  Copyright © 2017 Windy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        print("RAISINSSSSSSSSSSSS")
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        
        
        for child in self.children {
            
        
            if child.name == "GenChar" {
                
                if let child = child as? SKSpriteNode {
                    startGenWalkAnimation(forSprite: child)
                    
                    let move2 = SKAction.move(to: CGPoint(x: 2, y: child.position.y), duration:6)
                    move2.timingMode = SKActionTimingMode.easeOut
                    child.run(SKAction.sequence([move2,
                        SKAction.run({
                            child.removeAllActions()
                        })]
                    ))
                }
            } else if child.name == "HomeLessChar" {
                if let child = child as? SKSpriteNode {
                    startGenWalkAnimation(forSprite: child)
                    
                    let move2 = SKAction.move(to: CGPoint(x: -60, y: child.position.y), duration:6)
                    move2.timingMode = SKActionTimingMode.easeOut
                    child.run(SKAction.sequence([move2,
                         SKAction.run({
                            child.removeAllActions()
                         })]
                    ))
                }
            }
        }
        
        
    }
    
    
    func startGenWalkAnimation(forSprite child : SKSpriteNode) {
        let spriteAtlas = SKTextureAtlas(named: "Animation")
        var spriteFrames = [SKTexture]()
        
        for i in 1...9 {
            let spriteTextureName = "Generic-Character-\(i)"
            spriteFrames.append(spriteAtlas.textureNamed(spriteTextureName))
        }
        
        let firstFrame = spriteFrames[0]
        child.texture = firstFrame
        child.run(SKAction.repeatForever(
            SKAction.animate(with: spriteFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                  withKey:"Generic Characer Walks")
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
