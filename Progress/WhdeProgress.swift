//
//  WhdeProgress.swift
//  Progress
//
//  Created by whde on 16/4/7.
//  Copyright © 2016年 whde. All rights reserved.
//

import UIKit
class WhdeProgress: UIView {
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let layer:CALayer = CALayer.init()
        layer.frame = self.bounds;
        layer.backgroundColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(layer)
        
        let min:Int = 40
        let max:Int = 80
        let space:Int = 30
        let count:Double = Double.init((max-min)/space)+1
        var i:Double = 0
        for width in min.stride(to: max, by: space) {
            let shapeLayer = CAShapeLayer.init()
            shapeLayer.fillColor = UIColor.clearColor().CGColor
            shapeLayer.lineWidth = 5.0
            shapeLayer.strokeColor =  UIColor.greenColor().CGColor
            shapeLayer.strokeStart = 0.0
            shapeLayer.strokeEnd = 1
            shapeLayer.frame = CGRectMake(shapeLayer.lineWidth/2, shapeLayer.lineWidth/2, CGFloat.init(width), CGFloat.init(width));
            shapeLayer.backgroundColor = UIColor.clearColor().CGColor
            //            shapeLayer.position = self.convertPoint(self.center, fromView: self.superview);
            let path:UIBezierPath = UIBezierPath.init()
            path.moveToPoint(CGPointMake(CGFloat.init(width)/2+cos(CGFloat.init(2*M_PI/count*i))*CGFloat.init(width)/2, CGFloat.init(width)/2+sin(CGFloat.init(2*M_PI/count*i))*CGFloat.init(width)/2))
            path.addArcWithCenter(CGPointMake(CGFloat.init(width)/2, CGFloat.init(width)/2), radius: CGFloat.init(width)/2, startAngle:CGFloat.init(2*M_PI/count*i), endAngle:CGFloat.init(2*M_PI+2*M_PI/count*i), clockwise: true)
            shapeLayer.path = path.CGPath
            
            let gradientLayer:CAGradientLayer = CAGradientLayer.init()
            gradientLayer.frame = CGRectMake(0, 0, CGFloat.init(width)+shapeLayer.lineWidth, CGFloat.init(width)+shapeLayer.lineWidth)
            gradientLayer.colors = [UIColor.lightGrayColor().CGColor, UIColor.grayColor().CGColor, UIColor.greenColor().CGColor]
            gradientLayer.position = self.convertPoint(self.center, fromView: self.superview);
            gradientLayer.mask = shapeLayer
            gradientLayer.transform = CATransform3DMakeRotation(CGFloat.init(2*M_PI/count*i/2), 0, 0, 1)
            self.layer.addSublayer(gradientLayer)
            self.update(shapeLayer, gradientLayer:gradientLayer)
            i += 1
        }
    }
    func update(layer:CAShapeLayer, gradientLayer gLayer:CAGradientLayer) -> Void {
        let animation:CABasicAnimation = CABasicAnimation.init()
        animation.keyPath = "transform.rotation"
        animation.duration = 2.0
        animation.fromValue = CGFloat.init(0)
        animation.toValue = CGFloat.init((2*M_PI))
        animation.repeatCount = Float.infinity
        layer.addAnimation(animation, forKey: "transform.rotation")
        gLayer.addAnimation(animation, forKey: "transform.rotation")
        
        let timingFunction:CAMediaTimingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut);
        
        let headAnimation:CABasicAnimation = CABasicAnimation.init()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1
        headAnimation.fromValue = CGFloat.init(0)
        headAnimation.toValue = CGFloat.init(0.25)
        headAnimation.timingFunction = timingFunction
        
        let tailAnimation:CABasicAnimation = CABasicAnimation.init()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1
        tailAnimation.fromValue = CGFloat.init(0)
        tailAnimation.toValue = CGFloat.init(1)
        tailAnimation.timingFunction = timingFunction
        
        let endHeadAnimation:CABasicAnimation = CABasicAnimation.init()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.duration = 1
        endHeadAnimation.beginTime = 1
        endHeadAnimation.fromValue = CGFloat.init(0.25)
        endHeadAnimation.toValue = CGFloat.init(1)
        endHeadAnimation.timingFunction = timingFunction
        
        let endTailAnimation:CABasicAnimation = CABasicAnimation.init()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.duration = 1
        endTailAnimation.beginTime = 1
        endTailAnimation.fromValue = CGFloat.init(1)
        endTailAnimation.toValue = CGFloat.init(1)
        endTailAnimation.timingFunction = timingFunction
        
        let animations:CAAnimationGroup = CAAnimationGroup.init()
        animations.duration = 2
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float.infinity
        
        layer.addAnimation(animations, forKey: "animations")
    }
}