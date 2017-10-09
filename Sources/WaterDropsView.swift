//
//  WaterDropsView.swift
//  WaterDrops
//
//  Created by LeFal on 2017. 8. 17..
//  Copyright © 2017 LeFal. All rights reserved.
//

import UIKit

open class WaterDropsView: UIView {
    
    public typealias waterDropBuildClosure = (WaterDropsView) -> Void
    
    public enum DropDirection {
        case up
        case down
    }
    
    ///Number of drops
    open var dropNum: Int = 10
    
    ///Waterdrop's direction
    open var direction : DropDirection = .up
    
    ///Waterdrop's color
    open var color: UIColor = UIColor.blue.withAlphaComponent(0.7)
    ///The minimum size of a waterdrop
    open var minDropSize: CGFloat = 4
    ///The maximum size of a waterdrop
    open var maxDropSize: CGFloat = 10
    ///The minimum moving length of a waterdrop
    open var minLength: CGFloat = 0
    ///The maximum moving length of a waterdrop
    open var maxLength: CGFloat = 100
    ///The minimum duration of animation
    open var minDuration: TimeInterval = 4
    ///The maximum duration of animation
    open var maxDuration: TimeInterval = 12
    
    fileprivate var isStarted = false
    
    public init(frame: CGRect = CGRect.zero, build: waterDropBuildClosure) {
        super.init(frame: frame)
        build(self)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        resetRandomWaterDrop()
    }
    
    /// Required : Add water drops animation in view
    public func startAnimation() {
        isStarted = true
        makeRandomWaterDrops(num: dropNum, direction: direction)
    }
    
    public func stopAnimation() {
        isStarted = false
        self.layer.removeAllAnimations()
    }
    
    fileprivate func makeRandomWaterDrops(num: Int, direction: DropDirection = .up) {
        for _ in 1...num {
            randomWaterdrop(direction: direction)
        }
    }
    
    fileprivate func randomRect() -> CGRect {
        
        // make random number
        let randomX: CGFloat = CGFloat(arc4random_uniform(UInt32(self.frame.width)))
        let randomSize: CGFloat = CGFloat(arc4random_uniform(UInt32(self.maxDropSize - self.minDropSize))) + self.minDropSize
        // make waterdrop
        let positionY = direction == .up ? self.frame.height : -randomSize
        
        return CGRect(x: randomX, y: positionY, width: randomSize, height: randomSize)
    }
    
    fileprivate func randomWaterdrop(direction: DropDirection = .up) {
        
        let waterDropLayer = CAShapeLayer()
        let path = UIBezierPath(ovalIn: randomRect())
        
        waterDropLayer.path = path.cgPath
        waterDropLayer.fillColor = self.color.cgColor
        self.layer.addSublayer(waterDropLayer)
        
        startLayerAnimation(layer: waterDropLayer)
    }
    
    fileprivate func startLayerAnimation(layer: CAShapeLayer) {
        
        let randomDuration: TimeInterval = TimeInterval(arc4random_uniform(UInt32(self.maxDuration - self.minDuration))) + self.minDuration
        let randomLength: CGFloat = CGFloat(arc4random_uniform(UInt32(self.maxLength - self.minLength))) + self.minLength
        
        let length = direction == .up ? -randomLength : randomLength
        
        // animation
        let dropAnimation = CABasicAnimation(keyPath: "position.y")
        dropAnimation.fromValue = layer.position.y
        dropAnimation.toValue = layer.position.y + length
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = layer.opacity
        alphaAnimation.toValue = 0.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [dropAnimation, alphaAnimation]
        animationGroup.duration = randomDuration
        animationGroup.repeatCount = .greatestFiniteMagnitude
        layer.add(animationGroup, forKey: "animationGroup")
        
    }
    
    fileprivate func resetRandomWaterDrop() {
        
        if isStarted {
            self.layer.sublayers?.forEach({
                if let waterDropLayer = $0 as? CAShapeLayer {
                    waterDropLayer.path = UIBezierPath(ovalIn: randomRect()).cgPath
                    startLayerAnimation(layer: waterDropLayer)
                }
            })
        }
        
    }
}

