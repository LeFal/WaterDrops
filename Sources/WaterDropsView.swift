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
    fileprivate var viewConfiguration : ViewConfig?
    
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
        viewConfiguration = ViewConfig(minDropSize: self.minDropSize,
                                       maxDropSize: self.maxDropSize,
                                       minLength: self.minLength,
                                       maxLength: self.maxLength,
                                       minDuration: self.minDuration,
                                       maxDuration: self.maxDuration)
        makeRandomWaterDrops(num: dropNum, direction: direction)
    }
    
    public func stopAnimation() {
        isStarted = false
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    fileprivate func makeRandomWaterDrops(num: Int, direction: DropDirection = .up) {
        for _ in 1...num {
            randomWaterdrop(direction: direction)
        }
    }
    
    fileprivate func randomRect() -> CGRect {
        
        guard let config = viewConfiguration else {
            return CGRect.zero
        }
        
        // make random number
        let randomX: CGFloat = CGFloat(arc4random_uniform(UInt32(self.frame.width)))
        let randomSize: CGFloat = CGFloat(arc4random_uniform(UInt32(config.maxDropSize - config.minDropSize))) + config.minDropSize
          // make waterdrop
        let positionY = direction == .up ? self.frame.height : -randomSize

        return CGRect(x: randomX, y: positionY, width: randomSize, height: randomSize)
    }
    
    fileprivate func randomWaterdrop(direction: DropDirection = .up) {
        
        let waterdrop : UIView = UIView()
        waterdrop.frame = randomRect()
        
        waterdrop.backgroundColor = self.color
        waterdrop.layer.cornerRadius = waterdrop.frame.size.width/2
        self.addSubview(waterdrop)
        
        startViewAnimation(view: waterdrop)
    }

    fileprivate func startViewAnimation(view: UIView) {
        
        var randomDuration: TimeInterval = 3
        var randomLength: CGFloat = 30
        
        if let config = viewConfiguration {
            randomDuration = TimeInterval(arc4random_uniform(UInt32(config.maxDuration - config.minDuration))) + config.minDuration
            randomLength = CGFloat(arc4random_uniform(UInt32(config.maxLength - config.minLength))) + config.minLength
        }
        
        let length = direction == .up ? -randomLength : randomLength
        
        // animation
        UIView.animate(withDuration: randomDuration, delay: 0.0, options: .repeat, animations: {
            view.frame.origin.y += length
            view.alpha = 0.0
        }, completion: nil)

    }
    
    fileprivate func resetRandomWaterDrop() {
        
        if isStarted {
            self.subviews.forEach({
                $0.frame = randomRect()
                startViewAnimation(view: $0)
            })
        }
        
    }
    
    fileprivate struct ViewConfig {
        let minDropSize : CGFloat
        let maxDropSize: CGFloat
        let minLength : CGFloat
        let maxLength : CGFloat
        let minDuration : TimeInterval
        let maxDuration : TimeInterval
    }
}
